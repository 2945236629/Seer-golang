package com.robot.app.mapProcess
{
   import com.robot.app.fight.FightManager;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.event.RobotEvent;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.mode.OgreModel;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class MapProcess_11200 extends BaseMapProcess
   {
      
      private static var ogres:Array = [];
      
      private static var _bossId:int = 2948;
      
      private var _count:uint = 0;
      
      public function MapProcess_11200()
      {
         super();
      }
      
      override protected function init() : void
      {
         this.thisUpdate();
         LevelManager.iconLevel.visible = false;
         ToolBarController.panel.hide();
         this.addSprite();
         topLevel.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      override public function destroy() : void
      {
         this.removeSprite();
         topLevel.removeEventListener(MouseEvent.CLICK,this.onClick);
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
                  KTool.changeMapWithCallBack(1,function():void
                  {
                     ModuleManager.showAppModule("TwinsBrothersGivePanel");
                  });
               });
            }
            topLevel["countTxt"].text = _count + "/3";
         });
      }
      
      private function addSprite() : void
      {
         var _loc3_:OgreModel = null;
         this.removeSprite();
         ogres = [];
         var _loc1_:Array = [new Point(242,4008),new Point(650,400),new Point(753,470),new Point(350,470)];
         var _loc2_:int = 0;
         while(_loc2_ < 4)
         {
            _loc3_ = new OgreModel(_loc2_);
            ogres.push(_loc3_);
            _loc3_.addEventListener(RobotEvent.OGRE_CLICK,this.onClickBossHandler);
            _loc3_.show(_bossId,_loc1_[_loc2_]);
            _loc2_++;
         }
      }
      
      private function removeSprite() : void
      {
         var _loc1_:int = 0;
         var _loc2_:OgreModel = null;
         if(ogres)
         {
            _loc1_ = 0;
            while(_loc1_ < ogres.length)
            {
               _loc2_ = ogres[_loc1_];
               _loc2_.removeEventListener(RobotEvent.OGRE_CLICK,this.onClickBossHandler);
               _loc2_.destroy();
               _loc1_++;
            }
            ogres.splice(0);
         }
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
      
      private function onClickBossHandler(param1:RobotEvent) : void
      {
         FightManager.fightNoMapBoss("波切尔",6861);
      }
   }
}

