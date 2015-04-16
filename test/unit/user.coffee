'use strict';
#
#
#
#

$httpBackend = User = null

describe 'User', ->

  beforeEach(module('fastchat'))

  beforeEach inject ($injector)->
    User = $injector.get('User')

    $httpBackend = $injector.get '$httpBackend'
    authRequestHandler = $httpBackend.when('POST', '/v1/user/login')
      .respond(access_token: 'token')

  it 'should exist', ->
    expect(User).toBeDefined()

  it 'should have an email and password', ->
    user = new User('testing@test.com', 'test')
    expect(user.email).toBe('testing@test.com')
    expect(user.password).toBe('test')

  it 'should login', ->
    $httpBackend.expectPOST '/v1/user/login'
    user = new User('testing@test.com', 'test')
    user.login()
    $httpBackend.flush()
    expect(user.access_token).toBe('token')

  it 'should have a current user', ->
    $httpBackend.expectPOST '/v1/user/login'
    user = new User('testing@test.com', 'test')
    user.login()
    $httpBackend.flush()
    expect(user.access_token).toBe('token')

    user = User.currentUser()
    expect(user).not.toBe(null)
    expect(user.access_token).toBe('token')

  afterEach ->
    $httpBackend.verifyNoOutstandingExpectation()
    $httpBackend.verifyNoOutstandingRequest()
