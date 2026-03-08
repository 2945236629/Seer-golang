package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1992;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10503 extends BaseMapProcess
   {
      
      public function MapProcess_10503()
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
         mod1 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,1,"mc1"]);
         mod2 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MIUSI,["你到底是谁？我哥哥不会有这么强烈的暗黑能量！"],["我是你哥哥！"]);
         mod3 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.YELIMEISI_XIE,["你忘记我们小时候一起玩耍，一起学习吗？我是你的哥哥！"],["真是个虚伪的家伙？"]);
         mod4 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.KULUOLUOSI,["只要控制缪斯，就能够逼迫耶里梅斯出现。到时候就能够将魔石的能量据为己有！你的野心也太大了！"],["可恶！"]);
         mod5 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,2,"mc2"]);
         mod6 = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task_1992_1",true]);
         TaskDiaLogManager.single.playStory([mod1,mod2,mod3,mod4,mod5,mod6],function():void
         {
            TaskController_1992.completeNode4();
         });
      }
      
      public function get taskMc() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}

