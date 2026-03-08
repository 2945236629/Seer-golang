package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1973;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10482 extends BaseMapProcess
   {
      
      public function MapProcess_10482()
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
         var mod10:TaskMod;
         super.init();
         KTool.hideMapAllPlayerAndMonster();
         mod1 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,1,"mc1"]);
         mod2 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MOLINGKING,["没用的家伙！区区战神联盟就让你们怕成这样？若是咤克斯回来，知道这些，会被你们气死的！哈哈！"],["主人，我们知错了！"]);
         mod3 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.DIYUSHOU,["请再给我们一次机会吧！我们一定会彻底摧毁卡修斯的！"],["最好是这样！"]);
         mod4 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MOLINGKING,["你们要知道，卡修斯超进化之后的能量到底有多强大！集齐天地山川的能量，你们都不会是他的对手。所以，不能让他醒过来！"],["嗯！别做春秋大梦了！"]);
         mod5 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,2,"mc2"]);
         mod10 = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task_1973_3",true]);
         TaskDiaLogManager.single.playStory([mod1,mod2,mod3,mod4,mod5,mod10],function():void
         {
            TaskController_1973.completeNode4();
         });
      }
      
      public function get taskMC() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}

