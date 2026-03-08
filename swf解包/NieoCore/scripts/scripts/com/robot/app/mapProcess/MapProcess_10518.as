package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_3003;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10518 extends BaseMapProcess
   {
      
      public function MapProcess_10518()
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
         mod2 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.ASASI,["那…魔灵王，您的意思是说？"],["开战！"]);
         mod3 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MOLINGKING,["我们要让创世星的家伙知道我们暗夜城是不可侵犯的！"],["可是不都结束了吗？"]);
         mod4 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.YELIMEISI_XIE,["魔域三天王已经被索伦森控制在了天魔星的魔域之巅。难道创世星与暗夜城的恩怨还没有结束吗？"],["你太天真了！"]);
         mod5 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MOLINGKING,["我恳请公爵出击，与神域开战！毁灭创世星，祭奠所有为了暗夜城逝去的亡灵！"],["是的！为了所有逝去的亡灵！"]);
         mod6 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,2,"mc2"]);
         mod7 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.ASASI,["伊洛维奇，让我们开始复兴的征途吧！伟大的暗夜城必将成为泰坦星系的霸主！"],["父亲！"]);
         mod8 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.YELIMEISI_XIE,["请您不要再使用哀伤之剑了！你已经被魔石控制的失去理智了！一切都是魔灵王的阴谋！"],["一派胡言！"]);
         mod9 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MOLINGKING,["我对公爵大人一片忠心！你要知道，只有我们拥有强大的能量，才不会被神域的家伙伤害！我看你根本就想做叛徒！"],["你胡说！"]);
         mod10 = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task_3003_1",true]);
         TaskDiaLogManager.single.playStory([mod1,mod2,mod3,mod4,mod5,mod6,mod7,mod8,mod9,mod10],function():void
         {
            TaskController_3003.completeNode2();
         });
      }
      
      public function get taskMc() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}

