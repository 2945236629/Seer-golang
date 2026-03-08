package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1795;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10361 extends BaseMapProcess
   {
      
      private var _taskMC:MovieClip;
      
      public function MapProcess_10361()
      {
         super();
         KTool.hideMapAllPlayerAndMonster();
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         TaskDiaLogManager.single.playStory(this.stroyLine,function():void
         {
            TaskController_1795.completeNode3();
         });
      }
      
      private function get stroyLine() : Array
      {
         var _loc1_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,1,"mc1"]);
         var _loc2_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SHENGYIZHILING,["我来寻找我的朋友圣弓之灵戈麦斯，他一定就在这里！"],["这里没有什么圣弓之灵！"]);
         var _loc3_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.AILIYUSI,["我是月牙城主艾利尤斯，这里从来就没有什么圣弓之灵，你赶紧走吧！"],["他一定就在这里！"]);
         var _loc4_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SHENGYIZHILING,["我能够感受到他的气息，他就在这里，我有非常重要的事情必须找到他！"],["不要再在这里捣乱了！"]);
         var _loc5_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,2,"mc2"]);
         var _loc6_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.AILIYUSI,["他现在不想见任何人，你不要来打扰他了！"],["他？他果然在这里对吧！"]);
         var _loc7_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SHENGYIZHILING,["请你转告他一声，如果他还记得自己是创世神兵，就跟我一起回第六星系替创世之神报仇！"],["报什么仇？"]);
         var _loc8_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.AILIYUSI,["他现在已经习惯了平静的生活，复仇，战斗什么的对他来说没有任何吸引力了，你还是回去吧！"],["他可是圣弓之灵！"]);
         var _loc9_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SHENGYIZHILING,["没想到无坚不摧的圣弓之灵竟然已经失去了锋芒，既然这样，看来只能去找圣剑之灵休伊特了……"],["你还是走吧！"]);
         var _loc10_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,3,"mc3"]);
         var _loc11_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.GEMAISI,["好久不见了达芙妮，自从第六星系一别之后就再也没见了吧，你还是那么忠诚。"],["确实很久没见了。"]);
         var _loc12_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SHENGYIZHILING,["不过你已经懒惰了，戈麦斯，难道你就不想替创世之神报仇吗？"],["我当然想，不过时机未到。"]);
         var _loc13_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.GEMAISI,["我们只是创世之神的武器，会有一个新的主人带领我们才能发挥出最大的威力，不过他似乎还没有出现……"],["你是害怕了吗戈麦斯？"]);
         var _loc14_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SHENGYIZHILING,["现在第六星系已经被星云结界封锁了，你愿意和我去打破那个结界吗，早晚我们都要回到第六星系！"],["这个当然可以。"]);
         var _loc15_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,4,"mc4"]);
         return [_loc1_,_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_,_loc10_,_loc11_,_loc12_,_loc13_,_loc14_,_loc15_];
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

