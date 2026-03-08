package com.robot.app.mapProcess
{
   import com.robot.app.petbag.PetBagControllerNew;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.PetManager;
   import com.robot.core.manager.StatManager;
   import com.robot.core.manager.SystemTimerManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcDialog;
   import com.robot.core.ui.alert.Alarm2;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   import org.taomee.events.SocketEvent;
   import org.taomee.manager.ResourceManager;
   
   public class MapProcess_11144 extends BaseMapProcess
   {
      
      private var _mcDialog:MovieClip;
      
      private var _diamondsNum:int = 0;
      
      private var _interval:int = 0;
      
      private var _isPlaying:Boolean = false;
      
      private var _state:int = 0;
      
      private var _power:int = 0;
      
      private const MAX_DIAMONDS:int = 50000;
      
      public function MapProcess_11144()
      {
         super();
         StatManager.sendStat2014("0203钻石流星雨","打开场景钻石矿坑","2017运营活动");
      }
      
      override protected function init() : void
      {
         topLevel.mouseEnabled = false;
         topLevel.mouseChildren = false;
         btnLevel["mcDiging"].visible = false;
         depthLevel["weibin"].visible = false;
         conLevel["mcDiamond"].visible = false;
         this.updateMineCount(function():void
         {
            SystemTimerManager.addTickFun(onUpdate);
         });
         btnLevel["mcBar"].addEventListener(MouseEvent.CLICK,this.onClickBar);
         depthLevel["weibin"].addEventListener(MouseEvent.CLICK,this.onClickWeibin);
         conLevel["mcDiamond"].addEventListener(MouseEvent.CLICK,this.onClickDiamond);
         ResourceManager.getResource(ClientConfig.getAppRes("DiamondsMeteorShowerDialog"),function(param1:MovieClip):void
         {
            _mcDialog = param1;
            _mcDialog.addEventListener(MouseEvent.CLICK,onClickDialog);
            getState();
         },"item");
      }
      
      private function onClickWeibin(param1:*) : void
      {
         var e:* = param1;
         NpcDialog.show(NPC.WEIBING_NEW,["请大家保持秩序，钻石流星雨即将降临！对情况不太明白的赛尔，可以来询问我！想要兑换钻石的赛尔也可以来找我！"],["发生了什么？（我要兑换钻石）","我认错人了，不好意思."],[function():void
         {
            ModuleManager.showAppModule("DiamondsMeteorShowerExchangePanel");
         }]);
      }
      
      private function updateMineCount(param1:Function = null) : void
      {
         var callBack:Function = param1;
         KTool.getGlobalValues(121,[0],function(param1:Array):void
         {
            var _loc2_:int = param1[0] > MAX_DIAMONDS ? MAX_DIAMONDS : int(param1[0]);
            _diamondsNum = MAX_DIAMONDS - _loc2_;
            if(callBack != null)
            {
               callBack();
            }
            onUpdate();
         });
      }
      
      private function getState() : void
      {
         KTool.getMultiValue([3811,3810,13777],function(param1:Array):void
         {
            var values:Array = param1;
            _state = 0;
            _power = 30 - values[2];
            _power = _power < 0 ? 0 : _power;
            _mcDialog["mcNum"]["txtNum"].text = "" + _power;
            if(values[0] > 0 && values[0] < 5)
            {
               SocketConnection.sendWithCallback(45620,function(param1:SocketEvent):void
               {
                  _state = 0;
                  updateMineCount();
                  if(values[0] == 4)
                  {
                     --_power;
                     _power = _power < 0 ? 0 : _power;
                     _mcDialog["mcNum"]["txtNum"].text = "" + _power;
                  }
               },2,values[0],0);
            }
            else
            {
               _state = values[0];
            }
         });
      }
      
      private function onClickDialog(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         var name:String = e.target.name;
         switch(name)
         {
            case "btnClose":
               this._mcDialog.parent.removeChild(this._mcDialog);
               break;
            case "btnCure":
               PetManager.cureAll();
               break;
            case "btnBag":
               PetBagControllerNew.showByBuffer();
               break;
            case "btnFight":
               this._mcDialog.parent.removeChild(this._mcDialog);
               SocketConnection.sendWithCallback(45620,function(param1:SocketEvent):void
               {
               },2,5,0);
               break;
            case "btnDig":
               this._mcDialog.parent.removeChild(this._mcDialog);
               if(this._power > 0)
               {
                  SocketConnection.sendWithCallback(45620,function(param1:SocketEvent):void
                  {
                     var tmp:int = 0;
                     var num:int = 0;
                     var tmp2:int = 0;
                     var e:SocketEvent = param1;
                     var by:ByteArray = e.data as ByteArray;
                     tmp = int(by.readUnsignedInt());
                     if(tmp > 0)
                     {
                        num = int(by.readUnsignedInt());
                        tmp2 = num > MAX_DIAMONDS ? MAX_DIAMONDS : num;
                        _diamondsNum = MAX_DIAMONDS - tmp2;
                     }
                     btnLevel["mcDiging"].visible = true;
                     MovieClip(btnLevel["mcDiging"]["mcBar"]).gotoAndPlay(1);
                     AnimateManager.playMcEndHandler(MovieClip(btnLevel["mcDiging"]["mcBar"]),function():void
                     {
                        btnLevel["mcDiging"].visible = false;
                        _mcDialog.gotoAndStop(tmp + 2);
                        btnLevel.addChild(_mcDialog);
                        getState();
                     });
                  },2,0,0);
                  break;
               }
               Alarm2.show("很遗憾，你已经没有体力挖矿了！明天继续哦！");
         }
      }
      
      private function onClickDiamond(param1:MouseEvent) : void
      {
         var _loc2_:String = param1.target.name;
         if(_loc2_ == "mcDiamond" || _loc2_.indexOf("btnDia") == 0)
         {
            LevelManager.appLevel.addChild(this._mcDialog);
            this._mcDialog.visible = true;
            if(this._state == 0)
            {
               this._mcDialog.gotoAndStop(1);
            }
            else if(this._state == 5)
            {
               this._mcDialog.gotoAndStop(7);
            }
         }
      }
      
      private function onClickBar(param1:*) : void
      {
         var _loc2_:String = param1.target.name;
         if(_loc2_ == "btnExchange")
         {
            ModuleManager.showAppModule("DiamondsMeteorShowerExchangePanel");
         }
      }
      
      private function playAnim() : void
      {
         if(Boolean(this._mcDialog) && Boolean(this._mcDialog.parent))
         {
            this._isPlaying = false;
            return;
         }
         ResourceManager.getResource(ClientConfig.getMapAnimate("diamonds_meteor_shower"),function(param1:MovieClip):void
         {
            var mc:MovieClip = param1;
            btnLevel.addChild(mc);
            AnimateManager.playMcAnimate(mc,1,"mc",function():void
            {
               conLevel["mcDiamond"].visible = true;
               mc.parent.removeChild(mc);
               _isPlaying = false;
            });
         },"item");
      }
      
      private function onUpdate() : void
      {
         ++this._interval;
         var _loc1_:int = 60 * 30 - (SystemTimerManager.sysBJDate.minutes * 60 + SystemTimerManager.sysBJDate.seconds) % 1800;
         if(_loc1_ < 3 && !this._isPlaying)
         {
            this._isPlaying = true;
            this.playAnim();
            return;
         }
         var _loc2_:int = _loc1_ % 60;
         var _loc3_:int = _loc1_ / 60;
         if(this._diamondsNum == 0)
         {
            MovieClip(btnLevel["mcBar"]).gotoAndStop(1);
            KTool.showScore(btnLevel["mcBar"]["mcMin"],_loc3_,0,true);
            KTool.showScore(btnLevel["mcBar"]["mcSecond"],_loc2_,0,true);
            conLevel["mcDiamond"].visible = false;
            depthLevel["weibin"].visible = true;
         }
         else
         {
            MovieClip(btnLevel["mcBar"]).gotoAndStop(2);
            KTool.showScore(btnLevel["mcBar"]["mcNum"],this._diamondsNum);
            conLevel["mcDiamond"].visible = true;
            depthLevel["weibin"].visible = false;
         }
         if(this._interval == 10 || _loc1_ > 1798)
         {
            this.updateMineCount();
            this._interval = 0;
         }
      }
      
      override public function destroy() : void
      {
         btnLevel["mcBar"].removeEventListener(MouseEvent.CLICK,this.onClickBar);
         conLevel["mcDiamond"].removeEventListener(MouseEvent.CLICK,this.onClickDiamond);
         depthLevel["weibin"].removeEventListener(MouseEvent.CLICK,this.onClickWeibin);
         this._mcDialog.removeEventListener(MouseEvent.CLICK,this.onClickDialog);
         SystemTimerManager.removeTickFun(this.onUpdate);
         this._mcDialog = null;
         super.destroy();
      }
   }
}

