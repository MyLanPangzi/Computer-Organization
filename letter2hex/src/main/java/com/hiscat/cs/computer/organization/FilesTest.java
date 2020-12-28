package com.hiscat.cs.computer.organization;

import org.apache.commons.lang3.StringUtils;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;
import java.util.stream.Collectors;

public class FilesTest {
    public static void main(String[] args) throws IOException {
        List<String> collect = Files.lines(Paths.get("E:\\github\\Computer-Organization\\alpha.txt"))
                .map(String::trim)
                .filter(e -> !e.isEmpty())
                .collect(Collectors.toList());
        Integer max = collect.stream().map(String::length).max(Integer::compareTo).get();
        System.out.println(max);
        String s = collect.stream()
                .map(e -> StringUtils.rightPad(e, 8, " "))
                .map(e -> "\"" + e + "\"")
                .collect(Collectors.joining(","));
        System.out.println(s);
    }
}
