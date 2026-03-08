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
   
   public class MapProcess_10564 extends BaseMapProcess
   {
      
      public function MapProcess_10564()
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
         var _loc1_:Array = [new TaskMod(TaskDiaLogManager.DIALOG,NPC.PURGATORY_LORD,["就知道你在这里！依赖圣剑的力量消灭我们？哈哈哈哈！"],["对付你们还需要遵守规则吗？"]),new TaskMod(TaskDiaLogManager.DIALOG,NPC.HOLY_ARMOR_NIGHT,["对于你们，根本不需要任何解释。"],["我喜欢话不多的人。"]),new TaskMod(TaskDiaLogManager.DIALOG,NPC.EVIL_LORD,["既然终有一战，那你还等什么。"]),new TaskMod(TaskDiaLogManager.DIALOG,NPC.HOLY_ARMOR_NIGHT,["等一个时刻。"]),new TaskMod(TaskDiaLogManager.DIALOG,NPC.MOTUOTUO,["你们！你们不可以动我的东西。"]),new TaskMod(TaskDiaLogManager.DIALOG,NPC.HOLY_ARMOR_NIGHT,["你不要害怕，我知道这把剑的奥义。"],["你……你知道奥义？"]),new TaskMod(TaskDiaLogManager.DIALOG,NPC.PURGATORY_LORD,["这把剑的奥义……啊！那束圣光！！！！！！！！！"],["你想到了什么。"]),new TaskMod(TaskDiaLogManager.DIALOG,NPC.PURGATORY_LORD,["耶里梅斯用这把剑差点穿过我的身体！"],["没出息。"]),new TaskMod(TaskDiaLogManager.DIALOG,NPC.EVIL_LORD,["我也知道这把剑的奥义。只是不知道我们的答案是不是一样。"]),new TaskMod(TaskDiaLogManager.DIALOG,NPC.HOLY_ARMOR_NIGHT,["一样或者不一样，这把剑最后一定会伴着你的尸体长眠。"]),new TaskMod(TaskDiaLogManager.DIALOG,NPC.EVIL_LORD,["已经很久没人用这么冷静的口吻跟我说话，你从未见过魔界之人的可怕？"],["恰恰相反。"]),new TaskMod(TaskDiaLogManager
         .DIALOG,NPC.HOLY_ARMOR_NIGHT,["正是因为我曾经见到过，所以才不会惧怕，未知是恐惧的唯一来源。摩托托，把这把剑给我。"],["不给，除非你能说出这把剑的奥义。"]),new TaskMod(TaskDiaLogManager.DIALOG,NPC.HOLY_ARMOR_NIGHT,["这把剑的奥义……"]),new TaskMod(TaskDiaLogManager.DIALOG,NPC.PURGATORY_LORD,["小家伙！这把剑是我的啦！"]),new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task_3032_2",true]),new TaskMod(TaskDiaLogManager.DIALOG,NPC.PURGATORY_LORD,["什……么，没有……效果！"],["这不可能！"]),new TaskMod(TaskDiaLogManager.DIALOG,NPC.EVIL_LORD,["这怎么可能！！"]),new TaskMod(TaskDiaLogManager.DIALOG,NPC.HOLY_ARMOR_NIGHT,["这把剑的奥义就在于，迎接黎明，现在，黎明已经到来。"]),new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task_3032_3",true])];
         TaskDiaLogManager.single.playStory(_loc1_,TaskController_3032.completeNode4);
      }
      
      public function get taskMc() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}

