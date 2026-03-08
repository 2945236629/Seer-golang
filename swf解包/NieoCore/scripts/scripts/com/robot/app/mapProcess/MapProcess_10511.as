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
   
   public class MapProcess_10511 extends BaseMapProcess
   {
      
      public function MapProcess_10511()
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
         mod2 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.LEIYI,["阿萨斯，我们无意跟你决战到底！我们只需要带走缪斯。"],["带走她？"]);
         mod3 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.ASASI,["带走她，谁帮助我找到耶里梅斯？只要抓住缪斯，就一定能够逼耶里梅斯出现！"],["耶里梅斯？"]);
         mod4 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.ASASI,["传说只有他能够消灭魔石！只要消灭他，就没谁能够阻止我！别说是创世星，就是整个宇宙，都要臣服我！"],["狼子野心！"]);
         mod5 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,2,"mc2"]);
         mod6 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.ASASI,["当我手中握起“哀伤之剑”的那一刻开始，整个宇宙都不可能是我的对手！"],["可恶！"]);
         mod7 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.LEIYI,["阿萨斯，接受联盟的审判吧！"],["尽管来吧！"]);
         mod8 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,3,"mc3"]);
         TaskDiaLogManager.single.playStory([mod1,mod2,mod3,mod4,mod5,mod6,mod7,mod8],function():void
         {
            TaskController_1998.completeNode3();
         });
      }
      
      public function get taskMc() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}

