package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1970;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.TasksManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10476 extends BaseMapProcess
   {
      
      public function MapProcess_10476()
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
         if(TasksManager.getTaskStatus(1966) == TasksManager.UN_ACCEPT)
         {
            TasksManager.accept(1966);
         }
         KTool.hideMapAllPlayerAndMonster();
         mod1 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,1,"mc1"]);
         mod2 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.KALULU,["看来我们必须找到天地灵石才可以唤醒卡修斯    "],["拜托大家了！"]);
         mod3 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.DIFUTE,["我将在此守护卡修斯，如果邪恶势力突袭，到时候卡修斯就危险了！"],["那辛苦山神了！"]);
         mod4 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SEER,["赛小息，我们立即出发寻找天地灵石。 "],["天地灵石？"]);
         mod5 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,2,"mc2"]);
         mod6 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.AOLUONAER,["原来又是战神联盟成员！你以为我会怕你吗？小心自己也变成卡修斯这幅样子！"],["哼，大言不惭！"]);
         mod7 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.BULAIKE_NEW,["有我在这里，你休想动卡修斯一下！" + MainManager.actorInfo.formatNick + "寻找天地灵石的事情就拜托你们啦！"],["放心吧！"]);
         mod8 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SEER,["我们一定会成功找到的！这里就拜托你们了！"],["想走吗？"]);
         mod9 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,3,"mc3"]);
         TaskDiaLogManager.single.playStory([mod1,mod2,mod3,mod4,mod5,mod6,mod7,mod8,mod9],function():void
         {
            TaskController_1970.completeNode2();
         });
      }
      
      public function get taskMC() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}

