package com.wg.ga.as3;

import com.refracta.framework.helper.InputStreamHelper;
import com.refracta.framework.helper.RegexHelper;
import com.refracta.framework.util.FileUtil;
import com.sun.deploy.util.ReflectionUtil;
import org.reflections.Reflections;
import org.reflections.scanners.ResourcesScanner;
import org.reflections.scanners.SubTypesScanner;
import org.reflections.util.ClasspathHelper;
import org.reflections.util.ConfigurationBuilder;
import org.reflections.util.FilterBuilder;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.lang.reflect.*;
import java.util.*;

/**
 * 개발자 : refracta
 * 날짜   : 2014-08-07 오전 2:38
 */
public class ReflectionAs3Parser {
	public static void buildAs3(String rootPath, String packagePath) {
		List<Class<?>> classByPackage = getClassByPackage(packagePath);
		for (int i = 0; i < classByPackage.size(); i++) {
			Class<?> aClass = classByPackage.get(i);
			buildAs3File(rootPath, aClass);
		}
	}

	public static void buildAs3File(String rootPath, Class<?> aClass) {
		String packageName = aClass.getPackage().getName();
		String className = aClass.getSimpleName();
		String[] split = packageName.split("[.]");
		String pathBuilder = null;
		for (int i = 0; i < split.length; i++) {
			String s = split[i];
			if (i == 0) {
				pathBuilder = rootPath + s;
				new File(pathBuilder).mkdir();
			} else {
				pathBuilder = pathBuilder + "/" + s;
				new File(pathBuilder).mkdir();
			}
		}
		pathBuilder = pathBuilder + "/" + className + ".as";

		InputStreamHelper.saveInputStream(new ByteArrayInputStream(getClassData(packageName + "." + className).getBytes()), pathBuilder, FileUtil.getBufferSize());
	}


	public static List<Class<?>> getClassByPackage(String packagePath) {
		List<ClassLoader> classLoadersList = new LinkedList<ClassLoader>();
		classLoadersList.add(ClasspathHelper.contextClassLoader());
		classLoadersList.add(ClasspathHelper.staticClassLoader());
		Reflections reflections = new Reflections(new ConfigurationBuilder()
				.setScanners(new SubTypesScanner(false /* don't exclude Object.class */), new ResourcesScanner())
				.setUrls(ClasspathHelper.forClassLoader(classLoadersList.toArray(new ClassLoader[0])))
				.filterInputsBy(new FilterBuilder().include(FilterBuilder.prefix(packagePath))));
		Set<Class<?>> classes = reflections.getSubTypesOf(Object.class);
		Iterator<Class<?>> iterator = classes.iterator();
		ArrayList<Class<?>> returnArray = new ArrayList<>();
		while (iterator.hasNext()) {
			Class<?> next = iterator.next();
			returnArray.add(next);
		}
		return returnArray;
	}

	public static String getClassData(String classPackagePath) {
		StringBuffer classData = new StringBuffer();
		try {

			Class<?> aClass = Class.forName(classPackagePath);
			classData.append(aClass.getPackage().toString() + " {\n\n\t");

			if (Modifier.isPrivate(aClass.getModifiers())) {
				classData.append("private");
				classData.append(" ");
			} else if (Modifier.isProtected(aClass.getModifiers())) {
				classData.append("protected");
				classData.append(" ");
			} else if (Modifier.isPublic(aClass.getModifiers())) {
				classData.append("public");
				classData.append(" ");
			} else if (Modifier.isNative(aClass.getModifiers())) {
				classData.append("native");
				classData.append(" ");
			}

			if (Modifier.isInterface(aClass.getModifiers())) {
				classData.append("interface");
				classData.append(" ");
			} else {
				classData.append("class");
				classData.append(" ");
			}


			//상속도 구현해야함? ㅅㅂ;
			classData.append(aClass.getSimpleName());
			classData.append(" ");
			if (aClass.getSuperclass() != null) {
				if (!aClass.getSuperclass().getSimpleName().equalsIgnoreCase("Object")) {
					classData.append("extends");
					classData.append(" ");
					classData.append(fixType(aClass.getSuperclass(),aClass.getGenericSuperclass()));
					classData.append(" ");
				}
			}
			if (aClass.getInterfaces().length > 0) {
				classData.append("implements");
				for (int i = 0; i < aClass.getInterfaces().length; i++) {
					classData.append(" ");
					classData.append(fixType(aClass.getInterfaces()[i],aClass.getGenericInterfaces()[i]));
					if (!(aClass.getInterfaces().length - 1 == i)) {
						classData.append(", ");
					}
				}
			}


			classData.append(" {");


			Method[] methods = aClass.getMethods();
			Method[] declaredMethods = aClass.getDeclaredMethods();
			Field[] fields = aClass.getFields();
			Field[] declaredFields = aClass.getDeclaredFields();
			HashSet<Method> conbineMethods = new HashSet<>();
/*			for (int i = 0; i < methods.length; i++) {
				conbineMethods.add(methods[i]);
			}*/
			for (int i = 0; i < declaredMethods.length; i++) {
				conbineMethods.add(declaredMethods[i]);
			}
			HashSet<Field> conbineFields = new HashSet<>();
			for (int i = 0; i < fields.length; i++) {
				conbineFields.add(fields[i]);
			}
			for (int i = 0; i < declaredFields.length; i++) {
				conbineFields.add(declaredFields[i]);
			}


			Constructor<?>[] constructors = aClass.getConstructors();
			classData.append("\n\n");
			classData.append("\t\t" + "//" + constructors.length + " Constructors" + "\n");
			classData.append("\t\t" + "//" + conbineMethods.size() + " Methods" + "\n");
			classData.append("\t\t" + "//" + conbineFields.size() + " Fields" + "\n");
			classData.append("\t\t" + "\n\n");

			classData.append("\t\t" + "//Fields\n");
			Iterator<Field> fieldIterator = conbineFields.iterator();
			while (fieldIterator.hasNext()) {
				Field next = fieldIterator.next();
				classData.append("\t\t" + parseJavaField(next) + "\n\n");
			}
			classData.append("\n\n");
			classData.append("\t\t" + "//Constructors\n");
			for (int i = 0; i < constructors.length; i++) {
				Constructor<?> constructor = constructors[i];
				classData.append("\t\t" + parseJavaConstructor(constructor) + "\n\n");
			}
			classData.append("\n\n");
			classData.append("\t\t" + "//Methods\n");
			Iterator<Method> methodIterator = conbineMethods.iterator();
			while (methodIterator.hasNext()) {
				Method next = methodIterator.next();
				classData.append("\t\t" + parseJavaFunction(next) + "\n\n");
			}
			classData.append("\n\n");
			classData.append("\t}\n");
			classData.append("}");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return classData.toString();
	}

	public static String parseJavaFunction(Method method) {
		StringBuffer as3Function = new StringBuffer();

		if (!Modifier.isInterface(method.getDeclaringClass().getModifiers())) {
			if (Modifier.isPrivate(method.getModifiers())) {
				as3Function.append("private");
				as3Function.append(" ");
			} else if (Modifier.isProtected(method.getModifiers())) {
				as3Function.append("protected");
				as3Function.append(" ");
			} else if (Modifier.isPublic(method.getModifiers())) {
				as3Function.append("public");
				as3Function.append(" ");
			} else if (Modifier.isNative(method.getModifiers())) {
				as3Function.append("native");
				as3Function.append(" ");
			}
		}

		if (Modifier.isFinal(method.getModifiers())) {
			as3Function.append("final");
			as3Function.append(" ");
		}
		if (Modifier.isStatic(method.getModifiers())) {
			as3Function.append("static");
			as3Function.append(" ");
		}
		as3Function.append("function");
		as3Function.append(" ");
		as3Function.append(method.getName() + "(");
		Class<?>[] parameterTypes = method.getParameterTypes();
		Type[] genericTypes = method.getGenericParameterTypes();
		for (int i = 0; i < parameterTypes.length; i++) {

			as3Function.append(createFieldCamel(parameterTypes[i].getSimpleName() + (i + 1)) + ":" + fixType(parameterTypes[i], genericTypes[i]));
			if (!(parameterTypes.length - 1 == i)) {
				as3Function.append(", ");
			}
		}
		as3Function.append(")");

		String returnTypeName = fixType(method.getReturnType(), method.getGenericReturnType());

		as3Function.append(":");
		as3Function.append(returnTypeName);

		if (Modifier.isInterface(method.getDeclaringClass().getModifiers())) {
			as3Function.append(";");
		} else {
			if (Modifier.isAbstract(method.getModifiers())) {
				as3Function.append(" {\n\n//abstract\n\t\t}");
			} else {
				as3Function.append(" {\n\n\t\t}");
			}
		}
		return as3Function.toString();
		//접근변경자, 스테틱, 리턴형 함수명 파라미터들
	}

	public static Type[] getParameterizedTypes(Object object) {
		Type superclassType = object.getClass().getGenericSuperclass();
		if (!ParameterizedType.class.isAssignableFrom(superclassType.getClass())) {
			return null;
		}
		return ((ParameterizedType) superclassType).getActualTypeArguments();
	}

	public static String fixType(Class<?> type, Type genericType) {
		boolean haveGeneric = genericType instanceof ParameterizedType;
		ParameterizedType castGenericType = null;
		Type[] typeArguments = new Type[0];
		if (haveGeneric) {
			castGenericType = (ParameterizedType) genericType;

			typeArguments = castGenericType.getActualTypeArguments();
		}


		String returnTypeName = type.getSimpleName();
		if (returnTypeName.equalsIgnoreCase("double")) {
			returnTypeName = "Number";
		}
		if (returnTypeName.equalsIgnoreCase("ArrayList")) {

			returnTypeName = "Vector." + "<" + typeArguments[0].toString() + ">";
		}
		return returnTypeName;
	}

	public static String parseJavaConstructor(Constructor constructor) {
		StringBuffer as3Function = new StringBuffer();
		if (Modifier.isPrivate(constructor.getModifiers())) {
			as3Function.append("private");
			as3Function.append(" ");
		} else if (Modifier.isProtected(constructor.getModifiers())) {
			as3Function.append("protected");
			as3Function.append(" ");
		} else if (Modifier.isPublic(constructor.getModifiers())) {
			as3Function.append("public");
			as3Function.append(" ");
		} else if (Modifier.isNative(constructor.getModifiers())) {
			as3Function.append("native");
			as3Function.append(" ");
		}

		if (Modifier.isFinal(constructor.getModifiers())) {
			as3Function.append("final");
			as3Function.append(" ");
		}
		if (Modifier.isStatic(constructor.getModifiers())) {
			as3Function.append("static");
			as3Function.append(" ");
		}
		as3Function.append("function");
		as3Function.append(" ");
		as3Function.append(constructor.getDeclaringClass().getSimpleName() + "(");
		Class<?>[] parameterTypes = constructor.getParameterTypes();
		Type[] genericTypes = constructor.getGenericParameterTypes();
		for (int i = 0; i < parameterTypes.length; i++) {
			as3Function.append(createFieldCamel(parameterTypes[i].getSimpleName() + (i + 1) + ":" + fixType(parameterTypes[i], genericTypes[i])));
			if (!(parameterTypes.length - 1 == i)) {
				as3Function.append(", ");
			}
		}
		as3Function.append(")");

		if (Modifier.isInterface(constructor.getDeclaringClass().getModifiers())) {
			as3Function.append(";");
		} else {
			if (Modifier.isAbstract(constructor.getModifiers())) {
				as3Function.append(" {\n\n//abstract\n\t\t}");
			} else {
				as3Function.append(" {\n\n\t\t}");
			}
		}
		return as3Function.toString();
		//접근변경자, 스테틱, 리턴형 함수명 파라미터들
	}

	public static String createFieldCamel(String str) {
		ArrayList<String> regexList = RegexHelper.regexPatternToArray("[A-Z]", str);
		char[] charStr = str.toCharArray();
		for (int i = 0; i < regexList.size(); i++) {
			int i1 = str.indexOf(regexList.get(i));
			charStr[i1] = regexList.get(i).toLowerCase().charAt(0);
			break;
		}

		return new StringBuffer().append(charStr).toString();
	}

	public static String parseJavaField(Field field) {
		StringBuffer as3Field = new StringBuffer();
		if (Modifier.isPrivate(field.getModifiers())) {
			as3Field.append("private");
			as3Field.append(" ");
		} else if (Modifier.isProtected(field.getModifiers())) {
			as3Field.append("protected");
			as3Field.append(" ");
		} else if (Modifier.isPublic(field.getModifiers())) {
			as3Field.append("public");
			as3Field.append(" ");
		} else if (Modifier.isNative(field.getModifiers())) {
			as3Field.append("native");
			as3Field.append(" ");
		}


		if (Modifier.isStatic(field.getModifiers())) {
			as3Field.append("static");
			as3Field.append(" ");
		}
		if (Modifier.isFinal(field.getModifiers())) {
			as3Field.append("final");
			as3Field.append(" ");
		} else {
			as3Field.append("var");
			as3Field.append(" ");
		}
		as3Field.append(field.getName());
		as3Field.append(":");
		as3Field.append(fixType(field.getType(), field.getGenericType()));
		as3Field.append(";");

		return as3Field.toString();
	}
}
