package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1810;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10368 extends BaseMapProcess
   {
      
      private var _taskMC:MovieClip;
      
      public function MapProcess_10368()
      {
         super();
         KTool.hideMapAllPlayerAndMonster();
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         TaskDiaLogManager.single.playStory(this.stroyLine,function():void
         {
            TaskController_1810.completeNode2();
         });
      }
      
      private function get stroyLine() : Array
      {
         var _loc1_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,1,"mc1"]);
         var _loc2_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.HAKENSA,["你们就是创世神兵吧？我年轻时离开龙族四处闯荡，去过一个神秘的地方，也许就是你们所说的第六星系……"],["是什么地方？快带我们去！"]);
         var _loc3_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SHENGYIZHILING,["现在第六星系被星云结界封锁，如果你能够带我们返回第六星系，我们一定会感激你的！"],["感激？你们用什么感激我？"]);
         var _loc4_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.HAKENSA,["我可不是一个助人为乐的善者，你们要从我这里得到什么，总得付出些东西吧！"],["你是想和我们做个交易？"]);
         var _loc5_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.GEMAISI,["在这之前我们也要确定你的消息有价值，你怎么证明你去过第六星系呢？"],["说得很对，我喜欢和你说话。"]);
         var _loc6_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,2,"mc2"]);
         var _loc7_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.HAKENSA,["怎么样？现在我们可以谈谈交易的事情了吧？"],["看来你的消息确实有价值。"]);
         var _loc8_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.GEMAISI,["说吧，你想要怎么交易？"],["我的条件很简单。"]);
         var _loc9_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.HAKENSA,["我才是真正的龙族之王，只要你们帮助我打败龙王子哈克萨斯，我就带你们去那个地方！"],["这个不难，只不过……"]);
         var _loc10_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SHENGYIZHILING,["我们和哈克萨斯素来没有恩怨，就这样莫名其妙地插手你们龙族的家事，有些不妥吧？"],["那你们是不肯答应我的条件了？"]);
         var _loc11_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,3,"mc3"]);
         var _loc12_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SHENGYIZHILING,["赛尔说的很有道理，虽然我不知道你们有什么恩怨，但是公平地决斗才是最有说服力的！"],["单挑我也不会畏惧哈克萨斯的！"]);
         var _loc13_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.HAKENSA,["我会用实力证明我才是真正的龙族之王，就从打败哈克萨斯开始！"],["这样最好。"]);
         var _loc14_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.GEMAISI,["哈肯撒，不如你换个条件吧，我们可以帮助你，但是不会介入龙族的恩怨。"],["既然是这样，我确实还有个愿望。"]);
         var _loc15_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.HAKENSA,["在打败哈克萨斯之前，我需要一块自己的领地修炼，这个对你们来说不是难事吧？"],["恩，这个没有问题。"]);
         var _loc16_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,4,"mc4"]);
         return [_loc1_,_loc2_,_loc3_,_loc4_,_loc6_,_loc7_,_loc8_,_loc9_,_loc10_,_loc11_,_loc12_,_loc13_,_loc14_,_loc15_,_loc16_];
      }
      
      private function get taskMC() : MovieClip
      {
         return conLevel["taskMC"] as MovieClip;
      }
      
      override public function destroy() : void
      {
         super.destroy();
         this._taskMC = null;
      }
   }
}

