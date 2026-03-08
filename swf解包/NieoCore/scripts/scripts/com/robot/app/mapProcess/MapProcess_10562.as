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
   
   public class MapProcess_10562 extends BaseMapProcess
   {
      
      public function MapProcess_10562()
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
         var _loc1_:Array = [new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,1,"mc1"]),new TaskMod(TaskDiaLogManager.DIALOG,NPC.PURGATORY_LORD,["圣剑！你是耶里梅斯！"],["魔界之人果然看上了暗夜城。"]),new TaskMod(TaskDiaLogManager.DIALOG,NPC.YELIMEISI,["现在我要保护他，你走吧。"]),new TaskMod(TaskDiaLogManager.DIALOG,NPC.PURGATORY_LORD,["你说你要保护一个毫无还手能力的妖王？哈哈，我只要动一动手指，那个小东西就会被折磨死。"]),new TaskMod(TaskDiaLogManager.DIALOG,NPC.YELIMEISI,["我奉劝你不要这么做，这是我的建议。"]),new TaskMod(TaskDiaLogManager.DIALOG,NPC.PURGATORY_LORD,["哦？！建议？从来没有人敢给我建议！不要以为你拿着圣剑我就会怕你，要知道这把剑的实力，岂是你这种精灵可以驱使的！"]),new TaskMod(TaskDiaLogManager.DIALOG,NPC.YELIMEISI,["这把圣剑有个很奇怪的地方，它嗜血，只要沾到罪恶精灵的血液，就会变得异常锋利！"]),new TaskMod(TaskDiaLogManager.DIALOG,NPC.PURGATORY_LORD,["何必如此呢，耶里梅斯，你能见到我，也要感谢你的兄弟！"],["伊洛维奇！他怎么了！"]),new TaskMod(TaskDiaLogManager.DIALOG,NPC.PURGATORY_LORD,["为了亲手终结妖王摩哥斯。哈哈哈！可你现在却在保护一个仇人！耶里梅斯，何为你内心的正义，现在能告诉我吗？"]),new TaskMod(TaskDiaLogManager.DIALOG,NPC.PURGATORY_LORD,["多亏了他求功心切，走火入魔，最终毁灭了自己。但那毁灭一刻所爆发的能量，硬是把魔界之门给震裂了！你若说宇宙中最强的能量，那肯定是当之无愧的。"],["他……为什么要这么做。"])
         ,new TaskMod(TaskDiaLogManager.DIALOG,NPC.YELIMEISI,["伊洛维奇……你……你这个傻瓜。"]),new TaskMod(TaskDiaLogManager.DIALOG,NPC.PURGATORY_LORD,["不必如此，哈哈哈，魔界里的人会告诉你什么才是正义。"]),new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,2,"mc2"]),new TaskMod(TaskDiaLogManager.DIALOG,NPC.YELIMEISI,["摩托托，你能守护好圣剑吗？"]),new TaskMod(TaskDiaLogManager.DIALOG,NPC.MOTUOTUO,["嗯，我可以。"]),new TaskMod(TaskDiaLogManager.DIALOG,NPC.YELIMEISI,["这把圣剑的真正奥义并非斩妖除魔，而是迎接黎明。"])];
         TaskDiaLogManager.single.playStory(_loc1_,TaskController_3032.completeNode2);
      }
      
      public function get taskMc() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}

