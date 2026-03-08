package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1820;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10374 extends BaseMapProcess
   {
      
      private var _taskMC:MovieClip;
      
      public function MapProcess_10374()
      {
         super();
         KTool.hideMapAllPlayerAndMonster();
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         TaskDiaLogManager.single.playStory(this.stroyLine,function():void
         {
            TaskController_1820.completeNode4();
         });
      }
      
      private function get stroyLine() : Array
      {
         var _loc1_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.GEMAISI,["达芙妮，你伤势怎么样了？"],["咳咳咳……伤得好重……"]);
         var _loc2_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.DAFUNI,["没想到这个迷宫那么危险，里面封印着这么强大的力量，果然不能硬闯……咳咳……"],["这里居然会有迷宫？"]);
         var _loc3_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.GEMAISI,["你记得我们的朋友圣戒之灵弗罗多吗？以前创世之神受伤全是靠他恢复的，他一定可以治好你！"],["圣戒之灵弗罗多？"]);
         var _loc4_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.DAFUNI,["可是我们去哪里找他呢？都已经失散了这么久了。"],["放心，我有办法！"]);
         var _loc5_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,1,"mc1"]);
         var _loc6_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SUOLUOSENG,["原来是圣翼之灵受伤了，看来第六星系果然不好闯，创世神兵也没有传说中那样无敌啊。"],["索伦森，你怎么会出现在这里。"]);
         var _loc7_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.GEMAISI,["你早就知道会很危险，所以让我们先去当探路石么？圣翼之灵就这样被你利用受伤了！"],["话也不能这样说。"]);
         var _loc8_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SUOLUOSENG,["毕竟我们的目的是相同的，过程中总要有些人付出代价，只不过你们是这个不幸的人。"],["虚伪阴险的家伙！"]);
         var _loc9_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,2,"mc2"]);
         var _loc10_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SUOLUOSENG,["弗罗多，圣翼之灵是被第六星系的力量所伤，恐怕不比我的伤势轻，你决定给谁医治了吗？"],["她是我的朋友，我必须医治她。"]);
         var _loc11_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.FULUODUO,["你们两个的伤势都很严重，我最多只能治好一个……"],["这样可就不好办了。"]);
         var _loc12_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SUOLUOSENG,["你可要想清楚了，我可能是唯一一个可以重生你妹妹的人，这是你唯一可以向我请求的机会。"],["不要相信索伦森！"]);
         var _loc13_:TaskMod = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task_1820_1",true]);
         var _loc14_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,3,"mc3"]);
         var _loc15_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SUOLUOSENG,["创世神兵，你们会后悔的。没有我的帮助，你们是不可能回到第六星系的！"],["那可真要谢谢你的好意了！"]);
         var _loc16_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.DAFUNI,["说到底你不过是在利用我们，即使你有什么帮助我们也不需要，我们自己的力量足够了！"],["敬酒不吃吃罚酒！"]);
         var _loc17_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SUOLUOSENG,["你们果然和创世之神一样倔强，那好吧，我们走着瞧！"],["那就走着瞧吧！"]);
         var _loc18_:TaskMod = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task_1820_2"]);
         return [_loc1_,_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_,_loc10_,_loc11_,_loc12_,_loc13_,_loc14_,_loc15_,_loc16_,_loc17_,_loc18_];
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

