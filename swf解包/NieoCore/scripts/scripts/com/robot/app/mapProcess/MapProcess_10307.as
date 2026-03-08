package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import flash.display.MovieClip;
   
   public class MapProcess_10307 extends BaseMapProcess
   {
      
      public function MapProcess_10307()
      {
         super();
      }
      
      override protected function init() : void
      {
         KTool.hideMapAllPlayerAndMonster();
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         TaskDiaLogManager.single.playStory(this.taskList,function():void
         {
            MapManager.changeLocalMap(10310);
         });
      }
      
      private function get taskList() : Array
      {
         var _loc1_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,1,"mc1"]);
         var _loc2_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.JUSTIN,["迪恩…一定要想办法把你修好的，我贾斯汀发誓，不会再让你受到任何伤害！"],["看来迪恩伤的很重啊！"]);
         var _loc3_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,2,"mc2"]);
         var _loc4_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.XINJIDE,["一年前，你的朋友从天而降，身受重伤，像一堆废铁。我动用了自己身上的合金装甲，才勉强修好它。"]);
         var _loc5_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.XINJIDE,["但是，合金装甲一旦离开特定的环境，就只能保持10分钟的能量。"]);
         var _loc6_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.XINJIDE,["我要在迪恩重新变成一堆废铁前，把它带回未来。"]);
         var _loc7_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,3,"mc3"]);
         var _loc8_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.JUSTIN,["我能陪你们一起去吗？当年迪恩为我抵挡海盗炮弹的攻击，这次我想为他做些什么！"],["呵呵…原来就是你啊！"]);
         var _loc9_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.JUSTIN,["是的！说起这件事情我的内心一直有种内疚和惭愧，如果不是迪恩…我也不可能活着站在这里！"],["既然是这样…."]);
         var _loc10_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.XINJIDE,["你可要做好心理准备，因为想要前往机械迷城，我们必须借助派吉的光年电梯，在传送过程中你将会收到来自空间能量的巨大挤压！"],["不管怎样，我都要去！"]);
         var _loc11_:TaskMod = new TaskMod(TaskDiaLogManager.MAP_MOVIE,0,null,null,[this.taskMc,4,"mc4"]);
         var _loc12_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.XINJIDE,["那种支离破碎…零件纷纷掉落的感觉真是太难受了，跟上我，千万别迷失了方向！"],["不管怎样我一定不会退缩的！"]);
         var _loc13_:TaskMod = new TaskMod(TaskDiaLogManager.FUL_MOVIE,0,null,null,["task_10307_1",true]);
         return [_loc1_,_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_,_loc10_,_loc11_,_loc12_,_loc13_];
      }
      
      private function get taskMc() : MovieClip
      {
         if(conLevel == null)
         {
            return null;
         }
         return conLevel["taskMc"];
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}

