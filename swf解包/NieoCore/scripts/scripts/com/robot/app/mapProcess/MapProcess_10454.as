package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1952;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10454 extends BaseMapProcess
   {
      
      public function MapProcess_10454()
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
         mod1 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,1,"mc1"]);
         mod2 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SUOLUOSENG,["交给你们的事情做得怎么样？ "],["快好了！快好了！"]);
         mod3 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.ALLISON,["魔君大人！魔石的能量十分巨大，稍有不慎很有可能就会不受我们的控制！"],["多嘴！"]);
         mod4 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SUOLUOSENG,["这是我们魔灵星最后的希望！也是主人一直以来的梦想！你们认真做就对了！ "],["哈哈！"]);
         mod5 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,2,"mc2"]);
         mod6 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.ALLISON,["看来终于要轮到我们闪亮登场啦！快！把我们的战斗飞船修理好！该是战斗的时候了！"],["可是魔石精灵……"]);
         mod7 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.ZOG,["万一不受我们的控制！那后果真的不堪设想啊！"],["不用担心！"]);
         mod8 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.ALLISON,["反正现在一大批的魔石精灵都在赛尔飞船中！要是先灭亡也会是他们！大家加把劲！"],["好吧！"]);
         mod9 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.ZOG,["那我们赶紧去看看现在到底制造成什么样子了！千万不能出任何差错！"],["我们现在就去！"]);
         mod10 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,3,"mc3"]);
         TaskDiaLogManager.single.playStory([mod1,mod2,mod3,mod4,mod5,mod6,mod7,mod8,mod9,mod10],function():void
         {
            TaskController_1952.completeNode2();
         });
      }
      
      public function get taskMC() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}

