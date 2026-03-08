package com.robot.app.mapProcess
{
   import com.robot.app.fightLevel.FightPetBagController;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.CommandID;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.config.xml.PetXMLInfo;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.mode.AppModel;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.ui.alert.Alert;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.events.SocketEvent;
   import org.taomee.manager.ResourceManager;
   import org.taomee.manager.ToolTipManager;
   
   public class MapProcess_10037 extends BaseMapProcess
   {
      
      public static var _type:int;
      
      public static var _monCnt:int;
      
      public static var _monID:Array;
      
      public static var _animateMc:AppModel;
      
      private static var _isEnd:Boolean;
      
      public function MapProcess_10037()
      {
         super();
      }
      
      override protected function init() : void
      {
         ToolBarController.panel.hide();
         LevelManager.iconLevel.visible = false;
         conLevel["pet_mc"].visible = false;
         conLevel["pet_btn"].visible = false;
         conLevel["box_mc"].visible = false;
         conLevel["box_btn"].visible = false;
         conLevel["enter_mc"].visible = false;
         ToolTipManager.add(conLevel["petBag_btn"],"精灵背包");
         ToolTipManager.add(conLevel["leave_btn"],"太空站");
         conLevel["petBag_btn"].addEventListener(MouseEvent.CLICK,this.onPetBagClick);
         conLevel["leave_btn"].addEventListener(MouseEvent.CLICK,this.onLeaveClick);
         if(!_isEnd)
         {
            conLevel["enter_mc"].visible = true;
            AnimateManager.playMcAnimate(conLevel["enter_mc"],0,"",function():void
            {
               conLevel["enter_mc"].visible = false;
               _animateMc = new AppModel(ClientConfig.getAppModule("WheelAnimateMystery"),"正在加载神秘卡牌");
               _animateMc.setup();
               _animateMc.show();
               _animateMc.sharedEvents.addEventListener("TURN_COMPLETE",function():void
               {
                  _animateMc.sharedEvents.removeEventListener("TURN_COMPLETE",arguments.callee);
                  if(_type == 2)
                  {
                     conLevel["pet_mc"].visible = true;
                     AnimateManager.playMcAnimate(conLevel["pet_mc"],0,"",function():void
                     {
                        conLevel["pet_mc"].visible = false;
                        if(_monCnt > 0)
                        {
                           loadMonster(_monID.shift());
                        }
                        conLevel["pet_btn"].visible = true;
                        conLevel["pet_btn"].addEventListener(MouseEvent.CLICK,function(param1:MouseEvent):void
                        {
                           _isEnd = true;
                           conLevel["pet_btn"].removeEventListener(MouseEvent.CLICK,arguments.callee);
                           SocketConnection.send(CommandID.START_MYSTERY_SPACE);
                        });
                     });
                  }
                  else if(_type == 3)
                  {
                     conLevel["box_mc"].visible = true;
                     AnimateManager.playMcAnimate(conLevel["box_mc"],0,"",function():void
                     {
                        conLevel["box_mc"].visible = false;
                        conLevel["box_btn"].visible = true;
                        conLevel["box_btn"].addEventListener(MouseEvent.CLICK,function(param1:MouseEvent):void
                        {
                           _isEnd = true;
                           conLevel["box_btn"].removeEventListener(MouseEvent.CLICK,arguments.callee);
                           conLevel["box_btn"].visible = false;
                           SocketConnection.send(CommandID.START_MYSTERY_SPACE);
                        });
                     });
                  }
               });
            });
         }
      }
      
      private function loadMonster(param1:uint) : void
      {
         var monID:uint = param1;
         ResourceManager.getResource(ClientConfig.getPetSwfPath(monID),function(param1:DisplayObject):void
         {
            var _loc2_:MovieClip = param1 as MovieClip;
            (_loc2_.getChildAt(0) as MovieClip).gotoAndStop(1);
            ToolTipManager.add(_loc2_,PetXMLInfo.getName(monID));
            conLevel["pet_btn"].addChild(_loc2_);
            conLevel["pet_btn"].buttonMode = true;
            _loc2_.x = conLevel["pet_btn"].getChildIndex(_loc2_) * 60;
            if(_monID.length > 0)
            {
               loadMonster(_monID.shift());
            }
            else
            {
               conLevel["pet_btn"].x = (960 - conLevel["pet_btn"].width) / 2 + conLevel["pet_btn"].getChildAt(0).width / 2 + 5;
            }
         },"pet");
      }
      
      private function onPetBagClick(param1:MouseEvent) : void
      {
         FightPetBagController.show();
      }
      
      private function onLeaveClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         if(_isEnd)
         {
            this.leaveFight();
         }
         else
         {
            Alert.show("确定要离开闪光神秘空间吗？如果要再次进入，则需要再收集5个闪光之匙哦！",function():void
            {
               leaveFight();
            });
         }
      }
      
      private function leaveFight() : void
      {
         SocketConnection.addCmdListener(CommandID.LEAVE_MYSTERY_SPACE,this.onLeaveMystery);
         SocketConnection.send(CommandID.LEAVE_MYSTERY_SPACE);
      }
      
      private function onLeaveMystery(param1:SocketEvent) : void
      {
         ToolBarController.panel.show();
         LevelManager.iconLevel.visible = true;
         _type = 0;
         _monCnt = 0;
         _monID = [];
         _isEnd = false;
         MapManager.changeMap(405);
      }
      
      override public function destroy() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < conLevel["pet_btn"].numChildren)
         {
            conLevel["pet_btn"].removeChildAt(_loc1_);
            _loc1_++;
         }
         ToolTipManager.remove(conLevel["petBag_btn"]);
         ToolTipManager.remove(conLevel["leave_btn"]);
         conLevel["petBag_btn"].removeEventListener(MouseEvent.CLICK,this.onPetBagClick);
         conLevel["leave_btn"].removeEventListener(MouseEvent.CLICK,this.onLeaveClick);
      }
   }
}

