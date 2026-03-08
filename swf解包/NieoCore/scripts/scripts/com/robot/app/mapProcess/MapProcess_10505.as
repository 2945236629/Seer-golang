package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1996;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.TasksManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10505 extends BaseMapProcess
   {
      
      public function MapProcess_10505()
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
         if(TasksManager.getTaskStatus(1996) == TasksManager.UN_ACCEPT)
         {
            TasksManager.accept(1996);
         }
         KTool.hideMapAllPlayerAndMonster();
         mod1 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,1,"mc1"]);
         mod2 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.YELIMEISI_XIE,["你的瞳之神能根本无法伤害到我！看来耶里梅斯还是太爱护你了！"]);
         mod3 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.YELIMEISI_XIE,["不过也就到这里了！我可不像耶里梅斯那样软弱无能！今天，就把你埋葬在这里！"],["等等！"]);
         mod4 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,2,"mc2"]);
         mod5 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SEER,["缪斯少主，缪斯少主！醒一醒，醒一醒！"]);
         mod6 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SEER,["奇怪！这荒郊野岭的，缪斯怎么会晕倒在这里呢？一定是太劳累了！"],["是缪斯的哥哥！"]);
         mod7 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.AIDIKAILI,["是一个自称是缪斯的哥哥的家伙！还对着空气说话！"],["缪斯的哥哥？天蛇星盟主——耶里梅斯？"]);
         mod8 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,3,"mc3"]);
         TaskDiaLogManager.single.playStory([mod1,mod2,mod3,mod4,mod5,mod6,mod7,mod8],function():void
         {
            TaskController_1996.completeNode1();
         });
      }
      
      public function get taskMc() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}

