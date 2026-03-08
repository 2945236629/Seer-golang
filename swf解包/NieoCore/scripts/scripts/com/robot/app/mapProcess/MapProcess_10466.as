package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1962;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10466 extends BaseMapProcess
   {
      
      public function MapProcess_10466()
      {
         super();
      }
      
      override protected function init() : void
      {
         var mod1:TaskMod;
         var mod2:TaskMod;
         var mod3:TaskMod;
         var mod4:TaskMod;
         var mod5:TaskMod;
         super.init();
         KTool.hideMapAllPlayerAndMonster();
         mod1 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,1,"mc1"]);
         mod2 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MIUSI,["哥哥！你快回来！我坚持不住了！现在的一切都好难！我需要帮助卡修斯，但是我的实力远远不够！"],["可真是可怜！"]);
         mod3 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MIUSI,["是谁？你不是哥哥！是谁在这里？出来！！！"],["哈哈哈！"]);
         mod4 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,2,"mc2"]);
         mod5 = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task_1962_2",true]);
         TaskDiaLogManager.single.playStory([mod1,mod2,mod3,mod4,mod5],function():void
         {
            TaskController_1962.completeNode4();
         });
      }
      
      public function get taskMC() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}

