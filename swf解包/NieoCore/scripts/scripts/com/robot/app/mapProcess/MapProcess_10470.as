package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1966;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.TasksManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10470 extends BaseMapProcess
   {
      
      public function MapProcess_10470()
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
         super.init();
         if(TasksManager.getTaskStatus(1966) == TasksManager.UN_ACCEPT)
         {
            TasksManager.accept(1966);
         }
         KTool.hideMapAllPlayerAndMonster();
         mod1 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,1,"mc1"]);
         mod2 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.ATIEDA,["没想到我们把卡修斯当成好朋友，他反倒无情无义的攻击我们！真让人气愤！    "],["不是这样的！"]);
         mod3 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SEER,["阿铁打，你冷静冷静！卡修斯是被魔化了！他是被魔石精灵控制了。"],["太可怕了！"]);
         mod4 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.KALULU,[MainManager.actorInfo.formatNick + ",你看到没，卡修斯发怒的时候太可怕了！如果没有贾斯汀站长，我们就要死在那里了！  "],["不要担心！"]);
         mod5 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,2,"mc2"]);
         mod6 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.JUSTIN,["船长，不要忧心忡忡的，相信他们的实力！"],["嗯，但是……"]);
         mod7 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SHIPER,["还是没有赛小息的消息吗？他到底去了哪里？"]);
         mod8 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.JUSTIN,["没有！但是我隐约的感觉到赛小息还存活着。他一定会能够重返赛尔号的！"],["但愿如此吧！"]);
         mod9 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,3,"mc3"]);
         mod10 = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task_1966_11",true]);
         TaskDiaLogManager.single.playStory([mod1,mod2,mod3,mod4,mod5,mod6,mod7,mod8,mod9,mod10],function():void
         {
            TaskController_1966.completeNode1();
         });
      }
      
      public function get taskMC() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}

