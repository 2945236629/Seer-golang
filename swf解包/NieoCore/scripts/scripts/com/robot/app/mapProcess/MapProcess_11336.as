package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MapListenerManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.ui.alert.Alarm2;
   import com.robot.core.ui.alert.Alert;
   import com.robot.core.utils.CommonUI;
   import flash.display.BlendMode;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.ui.Mouse;
   import org.taomee.events.SocketEvent;
   
   public class MapProcess_11336 extends BaseMapProcess
   {
      
      private var _numCollect:int = 0;
      
      private var _tipNum:int = -1;
      
      private var _isShow:Boolean = false;
      
      public function MapProcess_11336()
      {
         super();
      }
      
      public static function randomRange(param1:Number, param2:Number) : Number
      {
         return Math.round(Math.random() * (param2 - param1)) + param1;
      }
      
      override protected function init() : void
      {
         conLevel.mouseChildren = conLevel.mouseEnabled = false;
         conLevel["maskMv"]["glass"].visible = false;
         KTool.hideMapAllPlayerAndMonster();
         LevelManager.iconLevel.visible = false;
         AnimateManager.playMcEndHandler(conLevel["mc_tip"],function():void
         {
            conLevel["maskMv"]["glass"].visible = true;
            conLevel.mouseChildren = conLevel.mouseEnabled = true;
            MapListenerManager.add(conLevel["goOut"],onClick);
            MapListenerManager.add(conLevel["show"],onClick);
            conLevel["maskMv"]["glass"].blendMode = BlendMode.ERASE;
            conLevel["maskMv"].blendMode = BlendMode.LAYER;
            conLevel["maskMv"].mouseChildren = false;
            conLevel["maskMv"].mouseEnabled = false;
            conLevel["find"].mouseChildren = false;
            conLevel["find"].mouseEnabled = false;
            ToolBarController.panel.hide();
            LevelManager.stage.addEventListener(Event.ENTER_FRAME,enterFrameHandler);
            KTool.getMultiValue([15228,5352],function(param1:Array):void
            {
               var _loc2_:int = 0;
               while(_loc2_ < 10)
               {
                  if(KTool.getBit(param1[0],_loc2_ + 1) == 1)
                  {
                     ++_numCollect;
                     conLevel["item_" + _loc2_].visible = false;
                     conLevel["item_" + _loc2_] = null;
                     conLevel["txtNum"].text = _numCollect + "/10";
                  }
                  _loc2_++;
               }
               _loc2_ = _numCollect;
               while(_loc2_ < 10)
               {
                  conLevel["item_" + _loc2_].x = randomRange(100,860);
                  conLevel["item_" + _loc2_].y = randomRange(120,500);
                  conLevel["item_" + _loc2_].buttonMode = true;
                  MapListenerManager.add(conLevel["item_" + _loc2_],onClick);
                  _loc2_++;
               }
               randomItem();
               if(KTool.getBit(param1[1],6) == 1)
               {
                  CommonUI.setEnabled(conLevel["show"],false);
                  _loc2_ = 0;
                  while(_loc2_ < 10)
                  {
                     if(conLevel["item_" + _loc2_])
                     {
                        (conLevel["item_" + _loc2_] as DisplayObject).parent.setChildIndex(conLevel["item_" + _loc2_],(conLevel["item_" + _loc2_] as DisplayObject).parent.numChildren - 1);
                        _tipNum = _loc2_;
                        break;
                     }
                     _loc2_++;
                  }
               }
               else
               {
                  CommonUI.setEnabled(conLevel["show"],true);
               }
            });
         },2);
      }
      
      private function randomItem() : void
      {
         var _loc1_:int = this._numCollect;
         while(_loc1_ < 10)
         {
            conLevel["item_" + _loc1_].visible = false;
            if(_loc1_ == this._numCollect)
            {
               conLevel["item_" + _loc1_].visible = true;
            }
            _loc1_++;
         }
      }
      
      private function enterFrameHandler(param1:Event) : void
      {
         if(LevelManager.stage.mouseY <= 120 && LevelManager.stage.mouseX >= 350 && LevelManager.stage.mouseX <= 600)
         {
            Mouse.show();
            conLevel["find"].x = 20;
            conLevel["find"].y = 20;
            conLevel["maskMv"]["glass"].x = 20;
            conLevel["maskMv"]["glass"].y = 20;
         }
         else
         {
            if(!this._isShow)
            {
               Mouse.hide();
            }
            conLevel["find"].x = LevelManager.stage.mouseX;
            conLevel["find"].y = LevelManager.stage.mouseY;
            conLevel["maskMv"]["glass"].x = LevelManager.stage.mouseX;
            conLevel["maskMv"]["glass"].y = LevelManager.stage.mouseY;
         }
      }
      
      private function onClick(param1:* = null) : void
      {
         var e:* = param1;
         var ename:String = e.target.name;
         var index:int = int(ename.split("_")[1]);
         switch(ename)
         {
            case "goOut":
               this._isShow = true;
               Alert.show("目前尚未找到所有的远古帝魂，你确定要退出吗？!",function():void
               {
                  SocketConnection.sendWithCallback(43192,function(param1:SocketEvent):void
                  {
                     var e:SocketEvent = param1;
                     LevelManager.stage.removeEventListener(Event.ENTER_FRAME,enterFrameHandler);
                     MapManager.changeMapWithCallback(1203,function():void
                     {
                        ModuleManager.showAppModule("HuangDiGetDiHun");
                     });
                  },6,1);
               },function():void
               {
                  _isShow = false;
               });
               break;
            case "show":
               this._isShow = true;
               Alert.show("是否愿意支付1钻石显示一个隐藏的远古帝魂？!",function():void
               {
                  KTool.buyProductByCallback(248554,1,function():void
                  {
                     KTool.doExchange(9303,function():void
                     {
                        var _loc2_:Shape = null;
                        var _loc1_:int = 0;
                        while(_loc1_ < 10)
                        {
                           if(conLevel["item_" + _loc1_])
                           {
                              (conLevel["item_" + _loc1_] as DisplayObject).parent.setChildIndex(conLevel["item_" + _loc1_],(conLevel["item_" + _loc1_] as DisplayObject).parent.numChildren - 1);
                              _tipNum = _loc1_;
                              _loc2_ = new Shape();
                              _loc2_.graphics.beginFill(16711680);
                              _loc2_.graphics.drawCircle(conLevel["item_" + _loc1_].x + 20,conLevel["item_" + _loc1_].y + 20,30);
                              _loc2_.graphics.endFill();
                              conLevel["maskMv"].addChild(_loc2_);
                              (conLevel["maskMv"] as Sprite).getChildAt((conLevel["maskMv"] as Sprite).numChildren - 1).blendMode = BlendMode.ERASE;
                              _isShow = false;
                              CommonUI.setEnabled(conLevel["show"],false);
                              break;
                           }
                           _loc1_++;
                        }
                     });
                  });
               },function():void
               {
                  _isShow = false;
               });
               break;
            case "item_" + index:
               ++this._numCollect;
               conLevel["item_" + index].visible = false;
               conLevel["item_" + index] = null;
               conLevel["txtNum"].text = this._numCollect + "/10";
               SocketConnection.send(43192,5,index + 1);
               if(this._tipNum == index)
               {
                  SocketConnection.send(43192,7,0);
                  (conLevel["maskMv"] as Sprite).removeChildAt((conLevel["maskMv"] as Sprite).numChildren - 1);
                  CommonUI.setEnabled(conLevel["show"],true);
               }
               if(this._numCollect >= 10)
               {
                  Mouse.show();
                  this._isShow = true;
                  Alarm2.show("恭喜你！你已经集齐了所有的远古帝魂。",function():void
                  {
                     SocketConnection.sendWithCallback(43192,function(param1:SocketEvent):void
                     {
                        var e:SocketEvent = param1;
                        LevelManager.stage.removeEventListener(Event.ENTER_FRAME,enterFrameHandler);
                        MapManager.changeMapWithCallback(1203,function():void
                        {
                           ModuleManager.showAppModule("HuangDiGetDiHun");
                        });
                     },6,1);
                  });
                  break;
               }
               this.randomItem();
         }
      }
      
      override public function destroy() : void
      {
         Mouse.show();
         LevelManager.iconLevel.visible = true;
         KTool.showMapAllPlayerAndMonster();
         ToolBarController.panel.show();
         LevelManager.stage.removeEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
         super.destroy();
      }
   }
}

