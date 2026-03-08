package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1996;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10507 extends BaseMapProcess
   {
      
      public function MapProcess_10507()
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
         KTool.hideMapAllPlayerAndMonster();
         mod1 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,1,"mc1"]);
         mod2 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.ASASI,["可怜的孩子！"],["少主……"]);
         mod3 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MOLINGKING,["伊洛维奇和耶里梅斯是同生同源的兄弟！为什么要让他少用瞳之神能？"],["他毕竟是我的义子！"]);
         mod4 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.ASASI,["我相信他有足够的实力找到耶里梅斯！只要找到耶里梅斯，我们就能够知道如何控制魔石！"],["少主英明"]);
         mod5 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,2,"mc2"]);
         mod6 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MOLINGKING,["如果没记错的话，创世之神死后，神魔之战爆发，就是那个时候天蛇星盟主遗失的伊洛维奇吧！"],["是的！"]);
         mod7 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.ASASI,["伊洛维奇天资聪颖，原本是天蛇星盟主的接班人。可惜在神魔之战中被父亲遗失。"],["这些他都不知道吧？"]);
         mod8 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,3,"mc3"]);
         TaskDiaLogManager.single.playStory([mod1,mod2,mod3,mod4,mod5,mod6,mod7,mod8],function():void
         {
            TaskController_1996.completeNode3();
         });
      }
      
      public function get taskMc() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}

