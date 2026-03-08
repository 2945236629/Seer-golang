package com.robot.app.mapProcess
{
   import com.robot.app.fight.FightManager;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.events.MouseEvent;
   
   public class MapProcess_11201 extends BaseMapProcess
   {
      
      private var _count:uint = 0;
      
      public function MapProcess_11201()
      {
         super();
      }
      
      override protected function init() : void
      {
         this.thisUpdate();
         LevelManager.iconLevel.visible = false;
         ToolBarController.panel.hide();
         this.addListener();
      }
      
      override public function destroy() : void
      {
         this.removeListener();
         LevelManager.iconLevel.visible = true;
         ToolBarController.panel.show();
      }
      
      private function thisUpdate() : void
      {
         KTool.getMultiValue([4309],function(param1:Array):void
         {
            var arr:Array = param1;
            _count = arr[0];
            if(_count >= 3)
            {
               KTool.changeMapWithCallBack(1,function():void
               {
                  ModuleManager.showAppModule("TwinsBrothersGivePanel");
               });
            }
            topLevel["countTxt"].text = _count + "/3";
         });
      }
      
      private function addListener() : void
      {
         topLevel.addEventListener(MouseEvent.CLICK,this.onClick);
         conLevel["boss"].addEventListener(MouseEvent.CLICK,this.bossClick);
      }
      
      private function removeListener() : void
      {
         topLevel.removeEventListener(MouseEvent.CLICK,this.onClick);
         conLevel["boss"].removeEventListener(MouseEvent.CLICK,this.bossClick);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         switch(evt.target.name)
         {
            case "leave":
               KTool.changeMapWithCallBack(1,function():void
               {
                  ModuleManager.showAppModule("TwinsBrothersGivePanel");
               });
               break;
            case "oneKey":
               KTool.buyProductByCallback(247198,1,function():void
               {
                  KTool.doExchange(8696,function():void
                  {
                     KTool.changeMapWithCallBack(1,function():void
                     {
                        ModuleManager.showAppModule("TwinsBrothersGivePanel");
                     });
                  });
               });
         }
      }
      
      private function bossClick(param1:MouseEvent) : void
      {
         FightManager.fightNoMapBoss("凡利迪",6862);
      }
   }
}

