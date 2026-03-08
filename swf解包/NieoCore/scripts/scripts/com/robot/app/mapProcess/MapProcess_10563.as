package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_3032;
   import com.robot.app.task.control.TaskRoadOfDevildom;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.TasksManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10563 extends BaseMapProcess
   {
      
      public function MapProcess_10563()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         if(TasksManager.getTaskStatus(TaskRoadOfDevildom.TASK_ID_EVIL_JUMPDOWN) == TasksManager.UN_ACCEPT)
         {
            TasksManager.accept(TaskRoadOfDevildom.TASK_ID_EVIL_JUMPDOWN);
         }
         KTool.hideMapAllPlayerAndMonster();
         var _loc1_:Array = [new TaskMod(TaskDiaLogManager.DIALOG,NPC.EVIL_LORD,["真可惜。"]),new TaskMod(TaskDiaLogManager.DIALOG,NPC.PURGATORY_LORD,["可惜什么！他有圣剑！那是圣剑！我敢保证！你也接不下那一剑！"],["的确，我接不下那一剑。"]),new TaskMod(TaskDiaLogManager.DIALOG,NPC.EVIL_LORD,["可失败就是失败，这是无法改变的。"],["难道你没有败过？"]),new TaskMod(TaskDiaLogManager.DIALOG,NPC.PURGATORY_LORD,["不要以为我不知道，你放走了不该放走的人！难道你不想在魔界生存了吗？"],["我放走他们，有我的道理。"]),new TaskMod(TaskDiaLogManager.DIALOG,NPC.EVIL_LORD,["但，我不会向你解释，用卑劣的手段折磨对手，简直就是侮辱自己。"],["你很高尚，你一直都是魔界里最高尚的。"]),new TaskMod(TaskDiaLogManager.DIALOG,NPC.PURGATORY_LORD,["你为什么不去拿圣剑？我觉得圣剑最值得你拥有才对。"],["很对，我正要去拿。"]),new TaskMod(TaskDiaLogManager.DIALOG,NPC.EVIL_LORD,["但我已经感受到黑夜的到来，这黑夜中，夹杂了一丝光线。"],["哈哈哈，我看到了，这一次你不要出手，我要让你看看我的实力！"]),new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,2,"mc2"]),new TaskMod(TaskDiaLogManager.DIALOG,NPC.HOLY_ARMOR_NIGHT,["魔神们，我们还有一战。"]),new TaskMod(TaskDiaLogManager.DIALOG,NPC.PURGATORY_LORD,["追！"],["等下，我知道他要去哪。"]),new TaskMod(TaskDiaLogManager.DIALOG,NPC.EVIL_LORD,["看来，他们不过如此，仍然要依靠圣剑之力来打败我们。"])];
         TaskDiaLogManager.single.playStory(_loc1_,TaskController_3032.completeNode3);
      }
      
      public function get taskMc() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}

