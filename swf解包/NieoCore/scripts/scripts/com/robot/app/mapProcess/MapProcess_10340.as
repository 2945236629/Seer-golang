package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1713;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10340 extends BaseMapProcess
   {
      
      public function MapProcess_10340()
      {
         super();
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
      
      override protected function init() : void
      {
         super.init();
         KTool.hideMapAllPlayerAndMonster();
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         TaskDiaLogManager.single.playStory(this.storyLine,function():void
         {
            TaskController_1713.completeNode3();
         });
      }
      
      protected function get storyLine() : Array
      {
         var _loc1_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,1,"mc1"]);
         var _loc2_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SUOLUOSENG,["安分点吧，我的祭品们，在我降临这个世界之后，我一定会感激你们曾经做出的共享，哈哈哈哈……"],["岂有此理……"]);
         var _loc3_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.LEIYI,["没想到今天我们战神联盟居然会沦为别人的祭品，真是莫大的羞辱！"],["那是你们之前还没有遇到真正的强者。"]);
         var _loc4_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.GAIYA,["如果这次能够脱身，我绝不会让自己再陷入这样的窘境！"],["哈哈，恐怕你们已经没有机会了。"]);
         var _loc5_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,2,"mc2"]);
         var _loc6_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SUOLUOSENG,["我还以为你早就死了，说起来你也是我的恩人，不过如果你还想阻止我，那可别怪我不客气了！"],["你给我闭嘴！"]);
         var _loc7_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MAFALIAO,["创造逆界之门是我一生最大的错误，今天我就要来弥补这个错误！"],["哈哈，你觉得你可以做到吗？"]);
         var _loc8_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.BOSIDIJIA,["索伦森，你离开了反转空间到这里，你的力量也无法完全施展吧，事情恐怕就没有你想得那么简单了！ "],["对我来说没有什么影响。"]);
         var _loc9_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,3,"mc3"]);
         var _loc10_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SUOLUOSENG,["玛法里奥，上次你已经阻挡了我数万年，这一次你休想再挡住我！ "],["原来你还记得。"]);
         var _loc11_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MAFALIAO,["既然我可以阻挡你一次，就可以来第二次，回你的魔域去吧！这里不属于你！ "],["这里终将属于我！"]);
         var _loc12_:TaskMod = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task_1713_1",true]);
         var _loc13_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,4,"mc4"]);
         var _loc14_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.LEIYI,["这就是暗黑魔君的实力吗，居然一抬手就创造了一个星球…… "],["确实太恐怖了……"]);
         var _loc15_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.LEIYI,["索伦森刚刚降临，而且已经失去了暗黑战神联盟，这时他的力量最为薄弱，我们一定要抓住机会！ "],["对，不能让他跑了！"]);
         var _loc16_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MAFALIAO,["即使他真的来了，我也不会惧怕他的！  "],["我们一起去追击他！"]);
         var _loc17_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,5,"mc5"]);
         var _loc18_:TaskMod = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task_1713_3",true]);
         return [_loc1_,_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_,_loc10_,_loc11_,_loc12_,_loc13_,_loc14_,_loc15_,_loc16_,_loc17_,_loc18_];
      }
      
      private function get taskMc() : MovieClip
      {
         return conLevel["taskMc"];
      }
      
      override public function setup() : void
      {
         super.setup();
      }
   }
}

