package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1792;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10358 extends BaseMapProcess
   {
      
      public function MapProcess_10358()
      {
         super();
         KTool.hideMapAllPlayerAndMonster();
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         TaskDiaLogManager.single.playStory(this.stroyLine,function():void
         {
            TaskController_1792.completeNode3();
         });
      }
      
      private function get stroyLine() : Array
      {
         var _loc1_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,1,"mc1"]);
         var _loc2_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SHENGYIZHILING,["我已经感受不到创世之神的气息了……难道他真的已经……"],["我没有骗你吧。"]);
         var _loc3_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SUOLUOSENG,["自从玛法里奥摧毁了逆界之门，这就是唯一的通道了，我们只能硬闯了。"],["是谁布下的这个结界？"]);
         var _loc4_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SHENGYIZHILING,["是杀死创世之神的凶手吗？这样强大的力量，确实是个厉害的角色！"],["这个有可能。"]);
         var _loc5_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SUOLUOSENG,["也许这个结界的目的就是为了防止你们创世六神兵回去复仇，把你们阻挡在外面，毕竟你们继承了创世之神的力量！"],["我必须要回去！"]);
         var _loc6_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,2,"mc2"]);
         var _loc7_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SUOLUOSENG,["你们真是如影随形啊，如果不是你们毁掉了逆界之门，我怎么会需要来这里？"],["这里是另一个通道吗？"]);
         var _loc8_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.LEIYI,["圣翼之灵，不要跟随索伦森了，他只是在利用你达到他邪恶的目的！"],["我也有我自己的目标。"]);
         var _loc9_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SHENGYIZHILING,["这件事情与第六星系之外的你们无关，是我们自己的恩怨，总之我一定要回去查个清楚，为创世之神报仇！"],["第六星系？"]);
         var _loc10_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,3,"mc3"]);
         var _loc11_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.LEIYI,["第六星系？宇宙中不是只有五个星系吗？为什么以前从来没有听说过。"],["我也没有听说过。"]);
         var _loc12_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.MAFALIAO,["一定是那个强大的结界封锁住了一切，外界无法感受到第六星系的存在！"],["看来确实是这样。"]);
         var _loc13_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.LEIYI,["看来我们需要分头行动了，赛尔号的力量也需要参与进来！"],["我们愿意帮助！"]);
         var _loc14_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMC,4,"mc4"]);
         return [_loc1_,_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_,_loc10_,_loc11_,_loc12_,_loc13_,_loc14_];
      }
      
      private function get taskMC() : MovieClip
      {
         return conLevel["taskMC"] as MovieClip;
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}

