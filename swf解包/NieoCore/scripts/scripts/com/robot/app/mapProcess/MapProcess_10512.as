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
   
   public class MapProcess_10512 extends BaseMapProcess
   {
      
      public function MapProcess_10512()
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
         super.init();
         KTool.hideMapAllPlayerAndMonster();
         mod1 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,1,"mc1"]);
         mod2 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MOLINGKING,["你当初说此生不再踏足棱石星，我以为是真的！"],["闭嘴"]);
         mod3 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.BULAIKE_NEW,["我没有你这样的叔叔！我再次警告你，不要再助纣为虐！你做的坏事还不够多吗？"],["坏事？"]);
         mod4 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,2,"mc2"]);
         mod5 = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task_1998_2",true]);
         TaskDiaLogManager.single.playStory([mod1,mod2,mod3,mod4,mod5],function():void
         {
            TaskController_1998.completeNode4();
         });
      }
      
      public function get taskMc() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}

