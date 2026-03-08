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
   
   public class MapProcess_11373 extends BaseMapProcess
   {
      
      public function MapProcess_11373()
      {
         super();
      }
      
      override protected function init() : void
      {
         MapListenerManager.add(conLevel["guard"],this.onClick);
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
               SocketConnection.send(45693,12,1);
               ModuleManager.showAppModule("ZLWSGetCyanPanel");
            });
         });
      }
      
      private function get dialogArr() : Array
      {
         var _loc4_:TaskMod = null;
         var _loc1_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SOLIDMAN,["你好啊，小赛尔，能拜托你一点事情吗？"],["好的"]);
         var _loc2_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SOLIDMAN,["请问你能帮我去找博士派克吗？"],["可以啊，要说什么事情呢？"]);
         var _loc3_:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SOLIDMAN,["是这样的，我想去圣战之巅看看。不过我要去博士派特那里拿一瓶饮料，我现在不能离开岗位，你能帮帮我吗。"],["去圣战之巅和拿饮料有什么关系？"]);
         _loc4_ = new TaskMod(TaskDiaLogManager.DIALOG,NPC.SOLIDMAN,["我之后会告诉你的。"],["好的"]);
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

