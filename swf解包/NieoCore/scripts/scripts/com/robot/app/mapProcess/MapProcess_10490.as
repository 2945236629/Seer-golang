package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1983;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.TasksManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10490 extends BaseMapProcess
   {
      
      public function MapProcess_10490()
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
         if(TasksManager.getTaskStatus(1983) == TasksManager.UN_ACCEPT)
         {
            TasksManager.accept(1983);
         }
         KTool.hideMapAllPlayerAndMonster();
         mod1 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,1,"mc1"]);
         mod2 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SAIXIAOXI,["尤曼斯的家园被科塔娜他们毁掉了！一夜之间全部化作了废墟！"],["真是可怜啊！"]);
         mod3 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SHIPER,["事情发展比我们想象的要严重很多。没想到魔灵王比索伦森还要凶残！"],["船长，您好！"]);
         mod4 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.YOUMANSI,["我是庞贝城的尤曼斯！今天特意来拜见船长，请求赛尔号对我们的支援！"],["发生了什么事情？"]);
         mod5 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,2,"mc2"]);
         mod6 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SEER,["如果是这样，我们可以立即前往寻找天神石，只要唤醒卡修斯，魔灵王的阴谋就一定会破灭的！"],["大家万事小心"]);
         mod7 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SHIPER,[MainManager.actorInfo.formatNick + "飞船资料中显示天神殿凶险万分，稍有不慎，就会进入时空裂痕！"],["放心吧船长！"]);
         mod8 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.ATIEDA,["凭借我们先锋队多年的实力，一定能够顺利完成任务的！"],["赛尔先锋队必胜！"]);
         mod9 = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task_1983_1",true]);
         TaskDiaLogManager.single.playStory([mod1,mod2,mod3,mod4,mod5,mod6,mod7,mod8,mod9],function():void
         {
            TaskController_1983.completeNode1();
         });
      }
      
      public function get taskMC() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}

