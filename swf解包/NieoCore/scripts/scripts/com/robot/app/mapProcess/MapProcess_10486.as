package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1981;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10486 extends BaseMapProcess
   {
      
      public function MapProcess_10486()
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
         mod1 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,1,"mc1"]);
         mod2 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MOLINGKING,["从古至今，我想要得到的东西，还没有得不到的！你不要白费力气了！滚吧！"],["可恶！"]);
         mod3 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.GAIYA,["你们想要打卡修斯的主意，休想！我誓死保护我的兄弟！"],["真是可笑！"]);
         mod4 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.AOLUONAER,["这个世界上居然还有人相信兄弟情义！让我来教训你吧！"],["难道我会怕你吗？"]);
         mod5 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,2,"mc2"]);
         mod6 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MOLINGKING,["哈哈哈！奥罗纳尔，你还是需要魔石的能量啊!乖乖的去寻找魔石吧！"],["魔石？"]);
         mod7 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.GAIYA,["原来拥有邪恶力量的魔石就是你们在控制！今天我一定要彻底解决你们！"],["那要看你的本事了！"]);
         mod8 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,3,"mc3"]);
         TaskDiaLogManager.single.playStory([mod1,mod2,mod3,mod4,mod5,mod6,mod7,mod8],function():void
         {
            TaskController_1981.completeNode2();
         });
      }
      
      public function get taskMC() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}

