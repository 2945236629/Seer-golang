package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.manager.MapListenerManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.ui.alert.Alarm2;
   import com.robot.core.ui.alert.Alert;
   import org.taomee.events.SocketEvent;
   
   public class MapProcess_1206 extends BaseMapProcess
   {
      
      private var _numCollect:int = 0;
      
      public function MapProcess_1206()
      {
         super();
      }
      
      override protected function init() : void
      {
         MapListenerManager.add(conLevel["goOut"],this.onClick);
         ToolBarController.showOrHideAllUser(false);
         this.fresh();
      }
      
      private function fresh() : void
      {
         KTool.getMultiValue([15229],function(param1:Array):void
         {
            var arr:Array = param1;
            _numCollect = arr[0];
            conLevel["txtNum"].text = _numCollect + "/10";
            if(_numCollect < 10)
            {
            }
            if(_numCollect >= 10)
            {
               Alarm2.show("恭喜你！你已经集齐了所有的远古帝魂。",function():void
               {
                  MapManager.changeMapWithCallback(1203,function():void
                  {
                     SocketConnection.sendWithCallback(43192,function(param1:SocketEvent):void
                     {
                        ModuleManager.showAppModule("HuangDiGetDiHun");
                     },6,2);
                  });
               });
            }
         });
      }
      
      private function onClick(param1:* = null) : void
      {
         var e:* = param1;
         switch(e.target.name)
         {
            case "goOut":
               Alert.show("目前尚未找到所有的远古帝魂，你确定要退出吗？!",function():void
               {
                  SocketConnection.sendWithCallback(43192,function(param1:SocketEvent):void
                  {
                     ModuleManager.showAppModule("HuangDiGetDiHun");
                  },6,2);
               });
         }
      }
      
      override public function destroy() : void
      {
         ToolBarController.showOrHideAllUser(true);
         super.destroy();
      }
   }
}

