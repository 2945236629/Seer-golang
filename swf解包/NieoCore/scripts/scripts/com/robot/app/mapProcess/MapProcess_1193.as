package com.robot.app.mapProcess
{
   import com.robot.app.petbag.PetBagControllerNew;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.manager.ItemManager;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.PetManager;
   import com.robot.core.manager.SystemTimerManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.ui.alert.SpecAlert;
   import flash.events.MouseEvent;
   import org.taomee.utils.Utils;
   
   public class MapProcess_1193 extends BaseMapProcess
   {
      
      public function MapProcess_1193()
      {
         super();
      }
      
      override protected function init() : void
      {
         LevelManager.iconLevel.visible = false;
         ToolBarController.panel.visible = false;
         topLevel.mouseEnabled = false;
         topLevel.mouseChildren = false;
         var _loc1_:int = 0;
         while(_loc1_ < 4)
         {
            conLevel.addEventListener(MouseEvent.CLICK,this.onClick);
            _loc1_++;
         }
         this.update();
         this.onTime();
      }
      
      private function onTime() : void
      {
         var _loc1_:uint = uint(SystemTimerManager.time);
         if(_loc1_ / 3600 % 2 == 0)
         {
            conLevel["flag_" + 0].visible = true;
            conLevel["flag_" + 1].visible = false;
         }
         else
         {
            conLevel["flag_" + 1].visible = true;
            conLevel["flag_" + 0].visible = false;
         }
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         var cls:* = undefined;
         var evt:MouseEvent = param1;
         switch(evt.target.name)
         {
            case "closeBtn":
               MapManager.changeMap(1);
               break;
            case "submitItemBtn":
               ModuleManager.showModule(ClientConfig.getAppModule("AmadeusStarHeraldMainPanel"),"正在打开....");
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
      
      private function update() : void
      {
         var arr:Array = null;
         arr = [1709719,1709720,1709721,1709722,1709723,1709724];
         ItemManager.updateItems(arr,function():void
         {
            var _loc1_:Array = new Array();
            var _loc2_:int = 0;
            while(_loc2_ < 6)
            {
               _loc1_[_loc2_] = ItemManager.getNumByID(arr[_loc2_]);
               conLevel["itemNumTx_" + _loc2_].text = String(_loc1_[_loc2_]);
               _loc2_++;
            }
         });
      }
      
      override public function destroy() : void
      {
         LevelManager.iconLevel.visible = true;
         ToolBarController.panel.visible = true;
         conLevel.removeEventListener(MouseEvent.CLICK,this.onClick);
         super.destroy();
      }
   }
}

