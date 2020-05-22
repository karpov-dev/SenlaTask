@IsTest
public with sharing class TaskDataFactory {

    public static Task getTaskWithWhoId(Id id) {
        return new Task(WhoId = id);
    }
}