package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1960;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.TasksManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10459 extends BaseMapProcess
   {
      
      public function MapProcess_10459()
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
         if(TasksManager.getTaskStatus(1960) == TasksManager.UN_ACCEPT)
         {
            TasksManager.accept(1960);
         }
         KTool.hideMapAllPlayerAndMonster();
         mod1 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,1,"mc1"]);
         mod2 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SEER,["船长，最近海盗集团似乎一直在预谋什么！这次绑架赛小息一定是他们计划的一部分！  "],["说得对！"]);
         mod3 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.JUSTIN,["根据我们掌握的信息，近期海盗研究基地汇聚了大量的能量。我们不能对海盗掉以轻心！"],["是的！"]);
         mod4 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SHIPER,["神域结界已经快被我们勇敢的赛尔击碎了！索伦森不会善罢甘休！我们必须时刻警惕！  "],["可是赛小息……"]);
         mod5 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.ATIEDA,["让我们再去泰坦星系调查清楚吧！我们一定要救回赛小息。不管前方有多少艰难险阻！ "],["船长，我也是！"]);
         mod6 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,2,"mc2"]);
         mod7 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SHIPER,["飞船所有赛尔前往五大星系搜救赛小息的行踪！赛尔先锋队立即前往泰坦星系寻找线索！"],["遵命！"]);
         mod8 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SHIPER,[MainManager.actorInfo.formatNick + "，务必要与赛尔先锋队成员同心协力！不能有任何闪失！随时向我汇报最新情况！"],["好的，船长！"]);
         mod9 = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task_1960_0",true]);
         TaskDiaLogManager.single.playStory([mod1,mod2,mod3,mod4,mod5,mod6,mod7,mod8,mod9],function():void
         {
            TaskController_1960.completeNode1();
         });
      }
      
      public function get taskMC() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}

