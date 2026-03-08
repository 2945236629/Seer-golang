package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1970;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.TasksManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10475 extends BaseMapProcess
   {
      
      public function MapProcess_10475()
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
         var mod88:TaskMod;
         var mod9:TaskMod;
         var mod10:TaskMod;
         super.init();
         if(TasksManager.getTaskStatus(1970) == TasksManager.UN_ACCEPT)
         {
            TasksManager.accept(1970);
         }
         KTool.hideMapAllPlayerAndMonster();
         mod1 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,1,"mc1"]);
         mod2 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SHIPER,["是赛小息？"],["放心吧，船长！"]);
         mod3 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SEER,["我们已经把之前的事情都告诉赛小息了。他是真的！他是真的赛小息！"],["真是太好了！"]);
         mod4 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SHIPER,["赛小息，到底发生了什么事情，这段时间你去了哪里？"],["遇到了尤曼斯！"]);
         mod5 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,2,"mc2"]);
         mod6 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.JUSTIN,["刚刚也是尤曼斯率领族人与我们一起击退了海盗集团的进攻！"],["这么厉害？"]);
         mod7 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SHIPER,["看来尤曼斯一族成为了赛尔飞船的大恩人！我一定要当面感谢他们！"]);
         mod8 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SAIXIAOXI,["不用啦，船长！尤曼斯已经和族人回城堡了。他们说有更重要的事情！"],["那只好下次了！"]);
         mod88 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SAIXIAOXI,["船长，我们快去解救卡修斯吧！尤曼斯说卡修斯只是暂时的沉睡，只要我们找到天地的四颗灵石就能够唤醒卡修斯！"],["嗯！这个正是我要说的！"]);
         mod9 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,3,"mc3"]);
         mod10 = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task_1970_3",true]);
         TaskDiaLogManager.single.playStory([mod1,mod2,mod3,mod4,mod5,mod6,mod7,mod8,mod88,mod9,mod10],function():void
         {
            TaskController_1970.completeNode1();
         });
      }
      
      public function get taskMC() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}

