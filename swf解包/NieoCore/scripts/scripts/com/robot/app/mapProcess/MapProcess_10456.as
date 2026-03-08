package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1952;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10456 extends BaseMapProcess
   {
      
      public function MapProcess_10456()
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
         var mod10:TaskMod;
         var mod11:TaskMod;
         var mod12:TaskMod;
         var mod13:TaskMod;
         super.init();
         KTool.hideMapAllPlayerAndMonster();
         mod1 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,1,"mc1"]);
         mod2 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.KETANA,["你的朋友又来找你帮忙了！有机会还是想了解了解你们之间的正义感到底是哪里来的！ "],["你不会明白的！"]);
         mod3 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.TEMENGLE,["科塔娜！回头是岸！索伦森想要依靠着魔石强大起来。你们，不过是他的傀儡而已。"],["又是你！"]);
         mod4 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.CHUANGSIBINGHUN,["科塔娜！你们到底想要做什么！想要利用魔石能量，称霸泰坦星系吗？痴心妄想！ "],["那就用实力来说话吧！"]);
         mod5 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,2,"mc2"]);
         mod6 = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task_1952_1",true]);
         mod7 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.CHUANGSIBINGHUN,["卡茨！卡茨！你有没有事情啊！没想到魔石能量竟然驱使卡茨替索伦森抵挡我的攻击！"],["太可恶了！"]);
         mod8 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SEER,["索伦森得到了魔石的能量，实力已经难以估量了！我们一定要小心啊"],["我们快走！"]);
         mod9 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.KALULU,["卡茨！你坚持住！我们一定会帮助你恢复好的！我们快走！我们一定要帮助卡茨！ "],["大家快离开！"]);
         mod10 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,3,"mc3"]);
         mod11 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.CHUANGSIBINGHUN,["我去追击海盗集团！你们先回赛尔号向罗杰船长汇报情况！我一定会救出赛小息的！"],["拜托啦！"]);
         mod12 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.ATIEDA,["赛小息！我的好朋友，你一定要平安回来啊！"],["快向船长汇报情况！"]);
         mod13 = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task_1952_2",true]);
         TaskDiaLogManager.single.playStory([mod1,mod2,mod3,mod4,mod5,mod6,mod7,mod8,mod9,mod10,mod11,mod12,mod13],function():void
         {
            TaskController_1952.completeNode4();
         });
      }
      
      public function get taskMC() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}

