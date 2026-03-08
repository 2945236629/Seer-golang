package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1795;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10360 extends BaseMapProcess
   {
      
      private var _taskMC:MovieClip;
      
      public function MapProcess_10360()
      {
         super();
         KTool.hideMapAllPlayerAndMonster();
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         TaskDiaLogManager.single.playStory(this.stroyLine,function():void
         {
            TaskController_1795.completeNode2();
         });
      }
      
      private function get stroyLine() : Array
      {
         var _loc1_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SHENGYIZHILING,["索伦森，是谁设下了星云结界这么强大的力量，目的就是为了阻止我们返回第六星系吗？"],["看来你们离开第六星系太久了……"]);
         var _loc2_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SUOLUOSENG,["我虽然不知道设下星云结界的是谁，但是神域拥有这样力量的人也不多，很好推测。"],["难道你是说……"]);
         var _loc3_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SHENGYIZHILING,["怎么会？他们都是创世之神忠实的战将，怎么会做出这样的事情？"],["人心难测，你还是太善良了。"]);
         var _loc4_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SUOLUOSENG,["你再想想是谁怂恿创世之神把你们创世六神兵分散在六大星系的，他的目的非常明显了。"],["他欺骗了创世之神！"]);
         var _loc5_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,1,"mc1"]);
         var _loc6_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.YILANDI,["主人，为什么我们不追上去？万一她跑了怎么办？"],["现在暂时不用。"]);
         var _loc7_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SUOLUOSENG,["我只是需要他们打开前往第六星系的通道，就让她去帮我们找到其他创世神兵吧！"],["其他创世神兵？"]);
         var _loc8_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.YILANDI,["我们为什么不直接回去呢？我感觉创世神兵的力量并不可靠，毕竟他们和我们不是一路人。"],["这个没有关系。"]);
         var _loc9_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SUOLUOSENG,["让他们神域自相残杀不是省了我们很多事吗？我们还有更重要的事情去做。"],["更重要的？什么事情？"]);
         var _loc10_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,2,"mc2"]);
         var _loc11_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SUOLUOSENG,["好好利用一下你们的外表，我们可以做出很多事情。"],["我明白了主人。"]);
         var _loc12_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.YILANDI,["单凭外表，估计所有人都会以为我们是雷伊和盖亚，哈哈，真有意思。"],["不过这只是伪装而已。"]);
         var _loc13_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SUOLUOSENG,["接下来的计划就看你们的表现了。"],["放心吧主人！"]);
         var _loc14_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,3,"mc3"]);
         return [_loc1_,_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_,_loc10_,_loc11_,_loc12_,_loc13_,_loc14_];
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

