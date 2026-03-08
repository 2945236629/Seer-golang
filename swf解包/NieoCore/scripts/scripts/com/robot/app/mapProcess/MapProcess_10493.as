package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1983;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10493 extends BaseMapProcess
   {
      
      public function MapProcess_10493()
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
         super.init();
         KTool.hideMapAllPlayerAndMonster();
         mod1 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,1,"mc1"]);
         mod2 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.KULUOLUOSI,["宙斯！你竟然胆敢阻挡我！"],["谁都不能阻止卡修斯封神！"]);
         mod3 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.ZHOUSI,["克罗诺斯！放弃吧！卡修斯完成封神，成功超进化是注定的！你休想得到卡修斯的能量！"],["你以为你能够阻止我吗？"]);
         mod4 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.KULUOLUOSI,["既然得不到卡修斯的能量，那么不如让卡修斯彻底沉睡！永远都不要醒来！"],["不要！"]);
         mod5 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,2,"mc2"]);
         mod6 = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task_1983_2",true]);
         TaskDiaLogManager.single.playStory([mod1,mod2,mod3,mod4,mod5,mod6],function():void
         {
            TaskController_1983.completeNode4();
         });
      }
      
      public function get taskMC() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}

