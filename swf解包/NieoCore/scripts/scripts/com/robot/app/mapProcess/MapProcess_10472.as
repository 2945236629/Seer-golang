package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1966;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10472 extends BaseMapProcess
   {
      
      public function MapProcess_10472()
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
         KTool.hideMapAllPlayerAndMonster();
         mod1 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,1,"mc1"]);
         mod2 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.LEIYI,["你最好就此休手！否则战神联盟不会放过你！    "],["呵！好大的口气！"]);
         mod3 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.AOLUONAER,["你以为我会怕你们吗？卡修斯已经濒临魔化的边缘，没有回头路了！"],["你说什么！"]);
         mod4 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MIUSI,["卡修斯那么善良，不可能就此被魔化的！  "],["那看一看吧！"]);
         mod5 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,2,"mc2"]);
         mod6 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SEER,["可恶！怎么会这样！雷伊，我们该怎么办啊！"],["看着卡修斯好难过啊！"]);
         mod7 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MIUSI,["我相信卡修斯一定能够挺过去的！"],["你们快走！"]);
         mod8 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.KAXIUSI_WHITE,["雷伊、缪斯，你们快走！我不想伤害你们！"],["我不会走的！"]);
         mod88 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.LEIYI,["从我们成为战神联盟的那一刻起，我就不会放弃任何一位成员！"],["小心！"]);
         mod9 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,3,"mc3"]);
         mod10 = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task_1966_12",true]);
         TaskDiaLogManager.single.playStory([mod1,mod2,mod3,mod4,mod5,mod6,mod7,mod8,mod88,mod9,mod10],function():void
         {
            TaskController_1966.completeNode3();
         });
      }
      
      public function get taskMC() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}

