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
   
   public class MapProcess_10517 extends BaseMapProcess
   {
      
      public function MapProcess_10517()
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
         KTool.hideMapAllPlayerAndMonster();
         mod1 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,1,"mc1"]);
         mod2 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MIUSI,["瞳之神能是天蛇星的绝技！只有天蛇一族才能够领悟！他怎么会呢？"],["难道他是天蛇一族？"]);
         mod3 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.KAXIUSI_WHITE,["也有可能是魔灵王制造的天蛇星盟主复制品！缪斯，你不要太在意了！能平安回来就好！"],["不！不可能！"]);
         mod4 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MIUSI,["如果是复制品，那么肯定不会使用瞳之神能！但是伊洛维奇的瞳之神能发出的威力，明显在我之上。甚至连我哥哥都不是他的对手！"],["那么厉害？"]);
         mod5 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,2,"mc2"]);
         mod6 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SEER,["怎…怎…怎么回事！刚刚的那个是…耶里梅斯？"],["看来天蛇盟主要回来了！"]);
         mod7 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.YOUMANSI,["不知道他的任务完成了没有！"],["什么任务？"]);
         mod8 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.YOUMANSI,["这个…我现在还不能告诉你！但是，请你们一定要保护好缪斯！她是这场战役胜利的希望！"],["事不宜迟！"]);
         mod9 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,3,"mc3"]);
         TaskDiaLogManager.single.playStory([mod1,mod2,mod3,mod4,mod5,mod6,mod7,mod8,mod9],function():void
         {
            TaskController_3003.completeNode1();
         });
      }
      
      public function get taskMc() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}

