import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;
import java.util.stream.Stream;

public class Main {

    private static int repeatsCount = 0;

    private static void addAllEntriesToMap(Path path,
                                           HashMap<String, String> map,
                                           HashMap<String, Set<String>> duplicates) {
        String row;
        try (BufferedReader csvReader = new BufferedReader(new FileReader(path.toFile()))) {

            while ((row = csvReader.readLine()) != null) {
                try {
                    String[] data = row.split(",");
                    checkHash(data[1], data[0], map, duplicates);
                } catch (Exception e) {
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static void checkHash(String hash, String message,
                                  HashMap<String, String> hashMap,
                                  HashMap<String, Set<String>> duplicates) {
        checkDuplicates(hash, message, hashMap, duplicates);
        hashMap.put(hash, message);
    }

    private static void checkDuplicates(String hash, String message,
                                        HashMap<String, String> hashMap,
                                        HashMap<String, Set<String>> duplicates) {
        if (hashMap.containsKey(hash)) {
            if (duplicates.containsKey(hash)) {
                Set<String> messages = duplicates.get(hash);
                if (!messages.contains(message)) {
                    messages.add(message);
                }
            } else {
                String existingMessage = hashMap.get(hash);
                if (!existingMessage.equals(message)) {
                    Set<String> duplicatesList = new HashSet<>();
                    duplicatesList.add(existingMessage);
                    duplicatesList.add(message);
                    duplicates.put(hash, duplicatesList);
                } else {
                    repeatsCount++;
                }
            }
        }
    }

    private static void writeCollisionsToFiles(HashMap<String, Set<String>> colissions) throws IOException {
        int i = 1;
        for (Map.Entry<String, Set<String>> entry :
                colissions.entrySet()) {
            BufferedWriter writer = new BufferedWriter(new FileWriter(String.format("colissions_%d.txt", i++)));
            int j = 1;
            for (String message : entry.getValue()) {
                writer.write(String.format("x%d:", j++));
                writer.write(message);
                writer.write("\n");
            }
            writer.write(String.format("hash:%s", entry.getKey()));
            writer.close();
        }
    }

    public static void main(String[] args) throws IOException {
        HashMap<String, String> hashes = new HashMap<>();
        HashMap<String, Set<String>> colissions = new HashMap<>();
        try (Stream<Path> paths = Files.walk(Paths.get("data")).parallel()) {
            paths
                    .filter(Files::isRegularFile)
                    .forEach(path -> addAllEntriesToMap(path, hashes, colissions));
        }
        System.out.println(String.format("Total hashes: %d", hashes.size()));
        System.out.println(String.format("Colissions count: %d", colissions.size()));
        System.out.println(String.format("Repeats count: %d", repeatsCount));

        writeCollisionsToFiles(colissions);

    }


}
