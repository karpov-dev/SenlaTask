public with sharing class TaskManager {

    public static List<Task> getTasksByWhoId(Id taskWhoId) {
        if (String.isBlank(taskWhoId)) return new List<Task>();

        return [
                SELECT Id, WhoId
                FROM Task
                WHERE WhoId = :taskWhoId
        ];
    }
}