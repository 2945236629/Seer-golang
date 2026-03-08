package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1987;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.TasksManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10494 extends BaseMapProcess
   {
      
      public function MapProcess_10494()
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
         super.init();
         if(TasksManager.getTaskStatus(1987) == TasksManager.UN_ACCEPT)
         {
            TasksManager.accept(1987);
         }
         KTool.hideMapAllPlayerAndMonster();
         mod1 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,1,"mc1"]);
         mod2 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.KULUOLUOSI,["没想到你被我的能量击穿，还能够活在我面前！看来，需要终极一击了！"],["我绝对不会惧怕你！"]);
         mod3 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.ZHOUSI,["这个世界绝对不能够让你们这些邪恶的家伙控制！就算是今天被你打败，我也绝对不会屈服！"],["还真是倔强！"]);
         mod4 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.KULUOLUOSI,["那么，既然自寻死路，我就给你这个机会！"],["休要猖狂！"]);
         mod5 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,2,"mc2"]);
         mod6 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.KULUOLUOSI,["既然自己出来了，也就不用我动手了，乖乖的将能量交给我吧！我可以免你一死！"],["你休想！"]);
         mod7 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.KAXIUSI_SUPER,["天地山川的能量只有受命于天的王者才能够得到，就凭你？哼！"],["放肆！"]);
         TaskDiaLogManager.single.playStory([mod1,mod2,mod3,mod4,mod5,mod6,mod7],function():void
         {
            TaskController_1987.completeNode1();
         });
      }
      
      public function get taskMc() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}

