package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1973;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.TasksManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10479 extends BaseMapProcess
   {
      
      public function MapProcess_10479()
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
         var mod6:TaskMod;
         var mod10:TaskMod;
         super.init();
         if(TasksManager.getTaskStatus(1973) == TasksManager.UN_ACCEPT)
         {
            TasksManager.accept(1973);
         }
         KTool.hideMapAllPlayerAndMonster();
         mod1 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,1,"mc1"]);
         mod2 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.KALULU,["卡修斯是炫彩山圣神禁地的守护者，而且从小就是我们的好朋友。他现在这样……"],["我们不能坐以待毙！"]);
         mod3 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SEER,["我担心海盗集团这次的目的就是怀特星！到时候卡修斯就凶多吉少了！"],["是的！"]);
         mod4 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SHIPER,["怀特星虽然有迪符特守护，但是迪符特的能量已经大不如曾经。我担心卡修斯……"],["我们立即出发！"]);
         mod5 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,2,"mc2"]);
         mod6 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SHIPER,["海盗集团的实力突然猛进，到底是为什么？难道真的是魔石？"]);
         mod10 = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task_1970_3",true]);
         TaskDiaLogManager.single.playStory([mod1,mod2,mod3,mod4,mod5,mod6,mod10],function():void
         {
            TaskController_1973.completeNode1();
         });
      }
      
      public function get taskMC() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}

