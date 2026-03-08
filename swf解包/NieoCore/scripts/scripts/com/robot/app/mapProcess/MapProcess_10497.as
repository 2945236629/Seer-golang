package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1987;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10497 extends BaseMapProcess
   {
      
      public function MapProcess_10497()
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
         var mod7:TaskMod;
         var mod8:TaskMod;
         var mod9:TaskMod;
         super.init();
         KTool.hideMapAllPlayerAndMonster();
         mod1 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,1,"mc1"]);
         mod2 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MIUSI,["我相信，我哥哥一定还活在世上！我一定要找到他！"],["缪斯少主！"]);
         mod3 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SEER,["寻找耶里梅斯一定要从长计议！咦？那个是？"],["地祇石？"]);
         mod4 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.YOUMANSI,["果然是地祇石！没想到魔灵王竟然将它镶嵌到地狱兽体内！"],["少主！"]);
         mod5 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,2,"mc2"]);
         mod6 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MOTUOTUO,["总算是走了！接下来就是我的世界啦！"]);
         mod7 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MOTUOTUO,["谁能够想到，我才是真正可以得到卡修斯超进化能量的王者！"]);
         mod8 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,3,"mc3"]);
         mod9 = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task_1987_1",true]);
         TaskDiaLogManager.single.playStory([mod1,mod2,mod3,mod4,mod5,mod6,mod7,mod8,mod9],function():void
         {
            TaskController_1987.completeNode4();
         });
      }
      
      public function get taskMc() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}

