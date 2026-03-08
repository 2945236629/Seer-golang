package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1981;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.TasksManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10485 extends BaseMapProcess
   {
      
      public function MapProcess_10485()
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
         super.init();
         if(TasksManager.getTaskStatus(1981) == TasksManager.UN_ACCEPT)
         {
            TasksManager.accept(1981);
         }
         KTool.hideMapAllPlayerAndMonster();
         mod1 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,1,"mc1"]);
         mod2 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SHIPER,["魔灵王？宇宙中一直有他的传说，没想到他真的存在！"],["他是谁？"]);
         mod3 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.JUSTIN,["魔灵王曾经与咤克斯一起撼动了整个宇宙的秩序！后来不知为何，突然消失。如今苏醒，恐怕……"],["没事！"]);
         mod4 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.ATIEDA,["有我们正义的赛尔先锋队在，不管他到底是谁，休想为非作歹！"],["万事小心！"]);
         mod5 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,2,"mc2"]);
         mod6 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SAIXIAOXI,["事不宜迟，我们立即出发！我相信这一切，尤曼斯一定都知道的"],["好的"]);
         mod7 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SHIPER,[MainManager.actorInfo.formatNick + "万事小心！贾斯汀站长，加强飞船的保卫，千万不能让海盗集团偷袭！"],["遵命！"]);
         mod8 = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task_1981_0",true]);
         TaskDiaLogManager.single.playStory([mod1,mod2,mod3,mod4,mod5,mod6,mod7,mod8],function():void
         {
            TaskController_1981.completeNode1();
         });
      }
      
      public function get taskMC() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}

