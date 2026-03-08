package com.robot.app.mapProcess
{
   import com.robot.app.petbag.PetBagControllerNew;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.event.RobotEvent;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.PetManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.ui.alert.SpecAlert;
   import flash.events.MouseEvent;
   import org.taomee.events.SocketEvent;
   import org.taomee.manager.EventManager;
   import org.taomee.utils.Utils;
   
   public class MapProcess_1183 extends BaseMapProcess
   {
      
      public function MapProcess_1183()
      {
         super();
      }
      
      override protected function init() : void
      {
         LevelManager.iconLevel.visible = false;
         ToolBarController.panel.visible = false;
         topLevel.mouseEnabled = false;
         topLevel.mouseChildren = false;
         conLevel.addEventListener(MouseEvent.CLICK,this.onConLevel);
         this.update();
      }
      
      public function onConLevel(param1:MouseEvent) : void
      {
         var cls:* = undefined;
         var event:MouseEvent = param1;
         switch(event.target.name)
         {
            case "closeBtn":
               MapManager.changeMapWithCallback(1,function():void
               {
                  ModuleManager.showModule(ClientConfig.getAppModule("FortyNineWarPackagePlusMainPanel"),"正在打开....");
               });
               break;
            case "aKeyUpgradeBtn":
               KTool.buyProductByCallback(247346,1,function():void
               {
                  SocketConnection.addCmdListener(45641,function(param1:SocketEvent):void
                  {
                     var e:SocketEvent = param1;
                     SocketConnection.removeCmdListener(45641,arguments.callee);
                     MapManager.changeMapWithCallback(1,function():void
                     {
                        ModuleManager.showModule(ClientConfig.getAppModule("FortyNineWarPackagePlusMainPanel"),"正在打开....");
                     });
                  });
                  SocketConnection.send(45641,6,4);
               },conLevel);
               break;
            case "buyBtn":
               EventManager.addEventListener(RobotEvent.CLOSE_MUL_BUY_PANEL,this.onBuySpHandler);
               ModuleManager.showModule(ClientConfig.getAppModule("MultiBuyPanel"),"",{
                  "productID":247351,
                  "iconID":1709128,
                  "exchangeID":8771
               });
               break;
            case "bagBtn":
               PetBagControllerNew.showByBuffer();
               break;
            case "cureBtn":
               if(MainManager.actorInfo.superNono)
               {
                  PetManager.cureAll();
                  break;
               }
               cls = Utils.getClass("com.robot.app.mapProcess.control.ColorfulPrivilegeWishController") as Class;
               if(cls.bonusType == 1)
               {
                  PetManager.cureAll();
                  break;
               }
               SpecAlert.show("恢复精灵体力需要花费50赛尔豆，成为超No用户即可享受永久免费恢复特权！",function():void
               {
                  PetManager.cureAll();
               });
         }
      }
      
      private function onBuySpHandler(param1:*) : void
      {
         EventManager.removeEventListener(RobotEvent.CLOSE_MUL_BUY_PANEL,this.onBuySpHandler);
         this.update();
      }
      
      private function update() : void
      {
         KTool.getMultiValue([3916],function(param1:Array):void
         {
            var va:Array = param1;
            var index:int = int(va[0]);
            conLevel["itemNumTx"].text = String(va[0]) + "/10";
            if(va[0] >= 10)
            {
               MapManager.changeMapWithCallback(1,function():void
               {
                  ModuleManager.showModule(ClientConfig.getAppModule("FortyNineWarPackagePlusMainPanel"),"正在打开....");
               });
            }
         });
      }
      
      override public function destroy() : void
      {
         LevelManager.iconLevel.visible = true;
         ToolBarController.panel.visible = true;
         conLevel.removeEventListener(MouseEvent.CLICK,this.onConLevel);
         super.destroy();
      }
   }
}

