package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1960;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   import flash.utils.getDefinitionByName;
   import gs.TweenLite;
   
   public class MapProcess_10460 extends BaseMapProcess
   {
      
      public function MapProcess_10460()
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
         mod2 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.ATIEDA,["卡修斯？你怎么样了？为什么你周围的能量如此的邪恶呢？发生了什么？  "],["接下来一切都要靠他自己了！"]);
         mod3 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.CHUANGSIBINGHUN,["卡修斯体内的两股能量相互冲击最后爆发！现在稍有差池，魔性的能量便会控制卡修斯！"],["怎么会这样！"]);
         mod4 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.KALULU,["现在赛小息被绑架！卡修斯还濒临入魔！我们到底该怎么办啊！索伦森太可恶了！  "],["呜呜呜呜！"]);
         mod5 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,2,"mc2"]);
         mod6 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SAIXIAOXI,["我这不是回来了嘛！没事！放心吧！"],["太棒了！"]);
         mod7 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.ATIEDA,["我还没有去把海盗的老窝给端了，你居然就自己回来了！哈哈！赛小息，你可真厉害啊！"],["等等！"]);
         mod8 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.CHUANGSIBINGHUN,["大家小心！他不是赛小息！"],["什么？"]);
         mod9 = new TaskMod(TaskDiaLogManager.DIALOG,NPC.ATIEDA,["创世兵魂，你在说什么啊！他明明就是我的好兄弟——赛小息！"],["小心！"]);
         mod10 = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,3,"mc3"]);
         TweenLite.delayedCall(2,function():void
         {
            getDefinitionByName("com.robot.app2.toolBar.nono.NonoHelperController").icon.visible = false;
         });
         TaskDiaLogManager.single.playStory([mod1,mod2,mod3,mod4,mod5,mod6,mod7,mod8,mod9,mod10],function():void
         {
            getDefinitionByName("com.robot.app2.toolBar.nono.NonoHelperController").icon.visible = true;
            TaskController_1960.completeNode2();
         });
      }
      
      public function get taskMC() : MovieClip
      {
         return MapManager.currentMap.controlLevel["animationContainer"];
      }
   }
}

