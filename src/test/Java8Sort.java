package test;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

public class Java8Sort implements Comparable<Java8Sort> {
    private int id;
    private int age;
    private String name;

    public Java8Sort(int id, int age, String name) {
        this.id = id;
        this.age = age;
        this.name = name;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public int compareTo(Java8Sort ob) {
        return name.compareTo(ob.getName());
    }

    @Override
    public boolean equals(final Object obj) {
        if (obj == null) {
            return false;
        }

        final Java8Sort std = (Java8Sort) obj;
        if (this == std) {
            return true;
        } else {
            return (this.name.equals(std.name) && (this.age == std.age));
        }

    }

    @Override
    public int hashCode() {
        int hashno = 7;
        hashno = 13 * hashno + (name == null ? 0 : name.hashCode());
        return hashno;

    }

    //lambda表达式：http://www.importnew.com/26080.html
    public static void main(String[] args) {
        List<Java8Sort> list = new ArrayList<Java8Sort>();
        list.add(new Java8Sort(2, 15, "aaa"));
        list.add(new Java8Sort(1, 17, "ccc"));
        list.add(new Java8Sort(3, 16, "bbb"));

        System.out.print("=============sort origin 1:\n");
        list.forEach(e->System.out.print(e.id + " "));
        System.out.print("\n");

        System.out.print("=============sort by name 2:\n");
        List<Java8Sort> slist = list.stream().sorted().collect(Collectors.toList());
        slist.forEach(e->System.out.print(e.id + " "));
        System.out.print("\norigin: ");
        list.forEach(e->System.out.print(e.id + " "));
        System.out.print("\n");

        System.out.print("=============sort by name reverseOrder 3:\n"); //倒序
        slist = list.stream().sorted(Comparator.reverseOrder()).collect(Collectors.toList());
        slist.forEach(e->System.out.print(e.id + " "));
        System.out.print("\norigin: ");
        list.forEach(e->System.out.print(e.id + " "));
        System.out.print("\n");

        System.out.print("=============sort by id 4:\n"); //按照id排序
        slist = list.stream().sorted(Comparator.comparing(Java8Sort::getId)).collect(Collectors.toList());
        slist.forEach(e->System.out.print(e.id + " "));
        System.out.print("\norigin: ");
        list.forEach(e->System.out.print(e.id + " "));
        System.out.print("\n");

        System.out.print("=============sort by id reverseOrder 5:\n"); //按照id倒序
        slist = list.stream().sorted(Comparator.comparing(Java8Sort::getId).reversed()).collect(Collectors.toList());
        slist.forEach(e->System.out.print(e.id + " "));
        System.out.print("\norigin: ");
        list.forEach(e->System.out.print(e.id + " "));
        System.out.print("\n");

        System.out.print("=============sort by age 6:\n"); //按照age排序
        slist = list.stream().sorted(Comparator.comparing(Java8Sort::getAge)).collect(Collectors.toList());
        slist.forEach(e->System.out.print(e.id + " "));
        System.out.print("\norigin: ");
        list.forEach(e->System.out.print(e.id + " "));
        System.out.print("\n");
    }
}
