package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.MapListenerManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.npc.NPC;
   import flash.events.MouseEvent;
   
   public class MapProcess_11376 extends BaseMapProcess
   {
      
      public function MapProcess_11376()
      {
         super();
      }
      
      override protected function init() : void
      {
         MapListenerManager.add(conLevel["npc"],this.onClick);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         KTool.hideMapAllPlayerAndMonster();
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         TaskDiaLogManager.single.playStory(this.dialogArr,function():void
         {
            MapManager.changeMapWithCallback(1,function():void
            {
               SocketConnection.send(45693,12,3);
               ModuleManager.showAppModule("ZLWSGetCyanPanel");
            });
         });
      }
      
      private function get dialogArr() : Array
      {
         var _loc4_:TaskMod = null;
         var _loc1_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SOLIDMAN,["谢谢你！小赛尔！我休息的时间不多，多亏你帮忙。"],["不客气。这次帮你拿药剂，似乎听别人说这里有故事。"]);
         var _loc2_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SOLIDMAN,["其实也没有什么啦。我最好的朋友，曾经梦想自己的雕像会雕刻在这里。"],["哈哈，只要他好好地准备，就会有这样一天的！"]);
         var _loc3_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SOLIDMAN,["我也希望啊。不过他很久都没有回来过了。我们以前都是一起来这里看看英雄们的雕像，一起喝这种饮料。真是好怀恋过去的时光呀！"],["你没有找过他吗？"]);
         _loc4_ = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SOLIDMAN,["小赛尔，我们是赛尔号上的卫兵。在各个星球上，我们都要好好地执勤，不能离开岗位的。虽然难以见到朋友，但我们是不能放下岗位和职责的。哈哈，不说这些了，谢谢你，小赛尔。希望有一天，能看见你的雕像！"],["希望你和你的朋友，能够再次团聚。"]);
         _loc1_.isNewDialog_1 = true;
         _loc2_.isNewDialog_1 = true;
         _loc3_.isNewDialog_1 = true;
         _loc4_.isNewDialog_1 = true;
         return [_loc1_,_loc2_,_loc3_,_loc4_];
      }
      
      override public function destroy() : void
      {
         KTool.showMapAllPlayerAndMonster();
         super.destroy();
      }
   }
}

