package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1998;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10510 extends BaseMapProcess
   {
      
      public function MapProcess_10510()
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
         KTool.hideMapAllPlayerAndMonster();
         mod1 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,1,"mc1"]);
         mod2 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.ASASI,["孩子，你不要忘记！这些天蛇星的家伙是怎么对你的！你现在的仁慈就是对自己的残忍！"],["我知道！"]);
         mod3 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.YELIMEISI_XIE,["父亲大人，让我亲手解决他吧！也算是我与天蛇星的一个了断！"],["好的！"]);
         mod4 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MIUSI,["你果然和天蛇星有关！你到底是谁？你为何与我哥哥长得这么像？"],["你不需要知道！"]);
         mod5 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.YELIMEISI_XIE,["缪斯！很可惜，今天就是你的末日了！去找你那该死的哥哥吧！"],["就凭你？"]);
         mod6 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,2,"mc2"]);
         mod7 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.ASASI,["既然战神联盟到齐了，那就从你们开始我的复国之路！"],["好强大的能量！"]);
         mod8 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.LEIYI,["你能否复国与我们无关，但我们必须带走缪斯！谁都不能阻止！"],["带走缪斯？"]);
         mod9 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MOLINGKING,["让你带走缪斯，我们怎么逼迫耶里梅斯现身？今天，缪斯必须死在伊洛维奇手下！"],["灭亡吧，哀伤之剑！"]);
         mod10 = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task_1998_1",true]);
         TaskDiaLogManager.single.playStory([mod1,mod2,mod3,mod4,mod5,mod6,mod7,mod8,mod9,mod10],function():void
         {
            TaskController_1998.completeNode2();
         });
      }
      
      public function get taskMc() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}

