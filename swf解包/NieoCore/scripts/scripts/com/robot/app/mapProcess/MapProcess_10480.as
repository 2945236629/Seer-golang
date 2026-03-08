package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1973;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10480 extends BaseMapProcess
   {
      
      public function MapProcess_10480()
      {
         super();
      }
      
      override protected function init() : void
      {
         var mod1:TaskMod;
         var mod2:TaskMod;
         var mod3:TaskMod;
         var mod5:TaskMod;
         var mod6:TaskMod;
         var mod7:TaskMod;
         var mod8:TaskMod;
         var mod9:TaskMod;
         super.init();
         KTool.hideMapAllPlayerAndMonster();
         mod1 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,1,"mc1"]);
         mod2 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.AOLUONAER,["哈哈哈！没想到拥有魔石的能量还不够，再加上卡修斯超进化的地祇石，地狱兽竟然如此厉害！"]);
         mod3 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.ZOG,["奥罗大人，可是如果地狱兽不听我们的指挥……后果不堪设想！"],["不听？"]);
         mod5 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,2,"mc2"]);
         mod6 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.AOLUONAER,["这么迫不及待啊！果然只要得到卡修斯超进化的能量，再加上魔石的侵蚀，实力就不可估量啊！"],["卡修斯在哪里？"]);
         mod7 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.DIYUSHOU,["只有消灭了卡修斯，我才能安心！地祇石才能够真正的属于我！"],["你可真是贪心啊！"]);
         mod8 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.ALLISON,["没想到我们海盗集团能够创造出如此强大的精灵！真是让人振奋啊！"],["不要松懈！"]);
         mod9 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,3,"mc3"]);
         TaskDiaLogManager.single.playStory([mod1,mod2,mod3,mod5,mod6,mod7,mod8,mod9],function():void
         {
            TaskController_1973.completeNode2();
         });
      }
      
      public function get taskMC() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}

