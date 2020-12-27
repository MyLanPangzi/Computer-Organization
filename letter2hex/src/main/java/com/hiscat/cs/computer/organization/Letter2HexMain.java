package com.hiscat.cs.computer.organization;

import cn.hutool.core.util.HexUtil;
import org.apache.commons.lang3.StringUtils;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;

public class Letter2HexMain {
    public static void main(String[] args) throws IOException {
        List<String> lines = Files.readAllLines(Paths.get("E:\\github\\Computer-Organization\\alpha.txt"));
        Integer max = lines.stream().map(String::length).max(Integer::compareTo).get();
        lines.stream()
                .map(String::trim)
                .filter(e -> !e.isEmpty())
                .map(e->StringUtils.rightPad(e,max," "))
                .map(e -> {

                    StringBuilder r = new StringBuilder();
                    StringBuilder sb = new StringBuilder();
                    int i = 0;
                    for (; i < e.length(); i++) {
                        if (i % 4 == 0 & i > 0) {
                            r.append("0x").append(HexUtil.encodeHexStr(StringUtils.reverse(sb.toString()))).append(" ");
                            sb.delete(0, 4);
                        }
                        sb.append(e.charAt(i));
                    }
                    if (sb.length() < 4) {
                        r.append("  0x0a").append(HexUtil.encodeHexStr(StringUtils.reverse(sb.toString())));
                    } else {
                        r.append("0x").append(HexUtil.encodeHexStr(StringUtils.reverse(sb.toString()))).append(" 0x0a");

                    }
                    return e.trim() + ": .word " + r.toString();
                })
                .forEach(System.out::println);
    }
}
