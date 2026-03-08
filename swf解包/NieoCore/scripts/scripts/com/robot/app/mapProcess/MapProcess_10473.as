package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1966;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10473 extends BaseMapProcess
   {
      
      public function MapProcess_10473()
      {
         super();
      }
      
      override protected function init() : void
      {
         var mod1:TaskMod;
         var mod2:TaskMod;
         var mod22:TaskMod;
         var mod10:TaskMod;
         super.init();
         KTool.hideMapAllPlayerAndMonster();
         mod1 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,1,"mc1"]);
         mod2 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.JUSTIN,["可恶！居然敢挑衅我！让我教训教训你们！    "],["站长，小心！"]);
         mod22 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.JUSTIN,["赛尔飞船的勇士，立即集结，迎战海盗集团！  "],["是"]);
         mod10 = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task_1966_13",true]);
         TaskDiaLogManager.single.playStory([mod1,mod2,mod22,mod10],function():void
         {
            TaskController_1966.completeNode4();
         });
      }
      
      public function get taskMC() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}

